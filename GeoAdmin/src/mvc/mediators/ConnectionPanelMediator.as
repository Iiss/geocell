package mvc.mediators 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import mvc.views.ConnectionPanel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.utils.LogService;
	/**
	 * ...
	 * @author liss
	 */
	public class ConnectionPanelMediator extends Mediator 
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var view:ConnectionPanel;
		
		[Inject]
		public var logger:LogService;
		
		public function ConnectionPanelMediator() 
		{
			super();
		}
		override public function initialize():void 
		{
			super.initialize();
			_validateState();
			eventMap.mapListener(sfs, SFSEvent.CONNECTION, _validateState);
			eventMap.mapListener(sfs, SFSEvent.CONNECTION_LOST, _validateState);
			eventMap.mapListener(sfs, SFSEvent.CONNECTION_RESUME, _validateState);
			eventMap.mapListener(sfs, SFSEvent.CONNECTION_RETRY, _validateState);
			
		}
		
		private function _validateState(e:*= null):void
		{
			view.currentState = sfs.isConnected ? "connected" : "disconnected";
		}
	}

}