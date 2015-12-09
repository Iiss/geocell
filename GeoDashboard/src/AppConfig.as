package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import mvc.mediators.*;
	import mvc.views.components.AnalyticControlPanel;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.geo.commands.*;
	import ru.marstefo.liss.geo.events.GameEvent;
	import ru.marstefo.liss.geo.mediators.*;
	import ru.marstefo.liss.geo.models.*;
	import ru.marstefo.liss.geo.views.components.CellInfoPanel;
	import ru.marstefo.liss.geo.views.components.LayerSelector;
	import ru.marstefo.liss.geo.views.ConsoleView;
	import ru.marstefo.liss.geo.views.MapView;
	import ru.marstefo.liss.net.commands.*;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	/**
	 * ...
	 * @author liss
	 */
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var eventCommandMap:IEventCommandMap;

		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var contextView:ContextView;
		
		public function AppConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(ConfigModel).asSingleton();
			injector.map(SessionModel).asSingleton();
			injector.map(WikiConfig).asSingleton();
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(App).toMediator(AppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(MapView).toMediator(MapViewMediator);
			mediatorMap.map(LayerSelector).toMediator(LayerSelectorMediator);
			mediatorMap.map(CellInfoPanel).toMediator(CellInfoPanelMediator);
			mediatorMap.map(AnalyticControlPanel).toMediator(AnalyticControlPanelMediator);
			//event
			eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			eventCommandMap.map(GameEvent.SCAN_REQUEST, GameEvent).toCommand(SendScanRequestCommand);
			eventCommandMap.map(SFSEvent.ROOM_VARIABLES_UPDATE, SFSEvent).toCommand(UpdateRoomVarsCommand);
			eventCommandMap.map(GameEvent.SELECT_CELL, GameEvent).toCommand(SelectCellCommand);
			eventCommandMap.map(GameEvent.SELECT_LAYER, GameEvent).toCommand(SelectLayerCommand);
			eventCommandMap.map(GameEvent.PING, GameEvent).toCommand(PingCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}