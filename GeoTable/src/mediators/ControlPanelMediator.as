package mediators 
{
	import flash.events.MouseEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.events.GameEvent;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import views.components.ControlPanel;
	/**
	 * ...
	 * @author liss
	 */
	public class ControlPanelMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:ControlPanel;
		
		public function ControlPanelMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sessionModel, SessionEvent.CELL_SELECTED, _update);
			eventMap.mapListener(sessionModel, SessionEvent.MAP_UPDATE, _update);
			eventMap.mapListener(sessionModel, SessionEvent.LAYER_SELECTED, _onLayerSelect);
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanClick);
			eventMap.mapListener(view.probeBtn, MouseEvent.MOUSE_DOWN, _onProbeClick);
		}
		
		private function _onLayerSelect(e:SessionEvent):void
		{
			view.legend.draw(sessionModel.currentLayer.legend);
			_update(e);
		}
		
		private function _update(e:SessionEvent):void
		{
			
		}
		
		private function _onScanClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.SCAN_RESULT, { 
									x: sessionModel.currentCell.x,
									y: sessionModel.currentCell.y,
									layer_id: sessionModel.currentLayer.id
									})
		}
		
		private function _onProbeClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.DELIVER_PROBE, { 
									x: sessionModel.currentCell.x,
									y: sessionModel.currentCell.y,
									layer_id: 4
									})
		}	
		
		private function _dispatchCommandEvent(eventType:String,data:Object=null):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
		
	}

}