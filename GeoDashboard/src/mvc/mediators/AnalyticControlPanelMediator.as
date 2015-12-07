package mvc.mediators 
{
	import flash.events.MouseEvent;
	import mvc.models.CellLayerModel;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.components.AnalyticControlPanel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.mvc.events.GameEvent;
	import mvc.models.WikiConfig;
	/**
	 * ...
	 * @author liss
	 */
	public class AnalyticControlPanelMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:AnalyticControlPanel;
		
		[Inject]
		public var wikiConfig:WikiConfig;
		
		public function AnalyticControlPanelMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sessionModel, SessionEvent.CELL_SELECTED, _update);
			eventMap.mapListener(sessionModel, SessionEvent.MAP_UPDATE, _update);
			eventMap.mapListener(sessionModel, SessionEvent.LOCKED, _onLock);
			eventMap.mapListener(sessionModel, SessionEvent.LAYER_SELECTED, _onLayerSelect);
			eventMap.mapListener(view.scanRequestBtn, MouseEvent.MOUSE_DOWN, _onScanRequestClick);
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanClick);
			eventMap.mapListener(view.probeBtn, MouseEvent.MOUSE_DOWN, _onProbeClick);
			eventMap.mapListener(view.placePlantBtn, MouseEvent.MOUSE_DOWN, _onPlacePlantClick);
			eventMap.mapListener(view.removePlantBtn, MouseEvent.MOUSE_DOWN, _onRemovePlantClick);
			eventMap.mapListener(view.wikiBtn, MouseEvent.MOUSE_DOWN, _showWiki);
		}
		
		private function _onLayerSelect(e:SessionEvent):void
		{
			view.legend.draw(sessionModel.currentLayer.legend);
			_update(e);
		}
		
		private function _update(e:SessionEvent):void
		{
			var scan_enabled:Boolean = false;
			if (sessionModel.currentLayer && sessionModel.currentCell)
			{
				var cl:CellLayerModel = sessionModel.currentCell.layers[sessionModel.currentLayer.id];
				scan_enabled = !cl.scanRequest && isNaN(cl.value)
					&& (!sessionModel.currentLayer.limit || sessionModel.currentLayer.limit > 0);
			}
			
			view.scanRequestBtn.enabled = scan_enabled
			view.scanBtn.enabled = sessionModel.currentLayer && sessionModel.currentCell 
				&& isNaN(sessionModel.currentCell.layers[sessionModel.currentLayer.id]);
		}
		
		private function _showWiki(e:MouseEvent):void
		{
			view.wiki.homeURL = wikiConfig.wikiURL;
			view.showWiki();
		}
		
		private function _onLock(e:SessionEvent):void
		{
			view.wiki.goHome();
			view.wiki.close();
		}
		
		private function _onScanRequestClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.SCAN_REQUEST, { 
									x: sessionModel.currentCell.x,
									y: sessionModel.currentCell.y,
									layer_id: sessionModel.currentLayer.id
									})
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
		
		private function _onPlacePlantClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.PLACE_PLANT, { 
									x: sessionModel.currentCell.x,
									y: sessionModel.currentCell.y
									})
		}
		
		private function _onRemovePlantClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.REMOVE_PLANT, { 
									plant_id: 2
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