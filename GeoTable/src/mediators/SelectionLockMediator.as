package mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import views.components.SelectionLock;
	
	public class SelectionLockMediator extends Mediator
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:SelectionLock;
		
		public function SelectionLockMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			_updateView();
			eventMap.mapListener(sessionModel, SessionEvent.LAYER_SELECTED, _updateView);
			eventMap.mapListener(sessionModel, SessionEvent.LAYERS_CHANGED, _updateView);
		}
		
		private function _updateView(e:*=null):void
		{
			var result:Boolean = false;
			if (sessionModel && sessionModel.currentLayer)
			{
				result = !sessionModel.currentLayer.enabled
			}	
			view.visible = result;
		}
	}
}