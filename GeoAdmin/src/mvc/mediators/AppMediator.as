package mvc.mediators 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.mvc.events.GameEvent;
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
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _dispatchForward);
			
			var t:Timer = new Timer(10000, 0);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			dispatch(new GameEvent(GameEvent.PING));
		}
		
		private function _dispatchForward(e:Event):void
		{
			dispatch(e);
		}
	}
}