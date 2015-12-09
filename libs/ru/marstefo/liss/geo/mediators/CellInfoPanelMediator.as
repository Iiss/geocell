package ru.marstefo.liss.geo.mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import ru.marstefo.liss.geo.views.components.CellInfoPanel;
	/**
	 * ...
	 * @author liss
	 */
	public class CellInfoPanelMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:CellInfoPanel;
		
		public function CellInfoPanelMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sessionModel, SessionEvent.CELL_SELECTED, _update);
			eventMap.mapListener(sessionModel, SessionEvent.MAP_UPDATE, _update);
		}
		
		private function _update(e:SessionEvent):void
		{
			view.showCellInfo(sessionModel.layers, sessionModel.currentCell);
		}
		
	}

}