package  
{
	import com.greensock.TweenNano;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import ru.marstefo.liss.geo.events.GameEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author liss
	 */
	public class AppMediator extends Mediator
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var view:App;
		
		[Inject]
		public var session:SessionModel;
		
		public function AppMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sfs, SFSEvent.ROOM_JOIN, _onConnection);
			eventMap.mapListener(session, SessionEvent.LOAD, _onSessionLoad);
			eventMap.mapListener(session, SessionEvent.LOCKED, _onSessionLoad);
			eventMap.mapListener(session, SessionEvent.UNLOCKED, _onSessionUnlock);
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _dispatchForward);
			////
			eventMap.mapListener(session, SessionEvent.CELL_SELECTED, _onCellSelected);
		}
		
		private function _dispatchForward(e:SFSEvent):void
		{
			dispatch(e);
		}
		private function _onSessionUnlock(e:SessionEvent):void
		{
			dispatch(new SessionEvent(SessionEvent.NEXT_SESSION));
		}
		
		private function _onConnection(e:SFSEvent):void
		{
			dispatch(new SessionEvent(SessionEvent.NEXT_SESSION));
			var t:Timer = new Timer(10000, 0);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			dispatch(new GameEvent(GameEvent.PING));
		}
		
		private function _onSessionLoad(e:SessionEvent):void
		{
			view.currentState = "loading";
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			TweenNano.delayedCall(3, _gotoGame);
		}
		
		private function _gotoGame():void
		{
			view.currentState = "in_game";
			Mouse.cursor = MouseCursor.ARROW;
		}
		
		private function _onCellSelected(e:SessionEvent):void
		{
			if (session.currentCell)
			{
				var ptx:Number = view.map.width / session.mapInfo.width*(session.currentCell.x+.5);
				var pty:Number = view.map.height / session.mapInfo.height*(session.currentCell.y+.5);
				view.selector.addPoint(new Point(ptx,pty));
			}
		}
	}

}