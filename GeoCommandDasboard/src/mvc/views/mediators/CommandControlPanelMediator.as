package mvc.views.mediators 
{
	import flash.events.MouseEvent;
	import mvc.models.CellLayerModel;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.components.AnalyticControlPanel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.mvc.events.GameEvent;
	import mvc.models.WikiConfig;
	import mvc.views.components.CommandControlPanel;
	/**
	 * ...
	 * @author liss
	 */
	public class CommandControlPanelMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:CommandControlPanel;
		
		[Inject]
		public var wikiConfig:WikiConfig;
		
		public function CommandControlPanelMediator() 
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
			var canPlacePlant:Boolean = sessionModel.currentCell != null && sessionModel.currentCell.plant == null;
			var canRemovePlant:Boolean = sessionModel.currentCell != null && sessionModel.currentCell.plant != null;
			view.placePlantBtn.visible = view.placePlantBtn.includeInLayout = canPlacePlant;
			view.removePlantBtn.visible = view.removePlantBtn.includeInLayout = canRemovePlant;
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
									plant_id: sessionModel.currentCell.plant.id
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