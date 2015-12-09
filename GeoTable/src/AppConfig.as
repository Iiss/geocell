package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import ru.marstefo.liss.geo.events.GameEvent;
	import mediators.SelectionLockMediator;
	import mediators.ControlPanelMediator
	import ru.marstefo.liss.geo.mediators.*;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import ru.marstefo.liss.geo.views.components.CellInfoPanel;
	import ru.marstefo.liss.geo.views.components.LayerSelector;
	import ru.marstefo.liss.geo.views.ConsoleView;
	import ru.marstefo.liss.geo.mediators.MapViewMediator;
	import ru.marstefo.liss.geo.views.MapView;
	import minigame.*;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	import views.components.SelectionLock;
	import views.components.ControlPanel;
	import ru.marstefo.liss.net.commands.PingCommand;
	import ru.marstefo.liss.geo.commands.*;
	import commands.*;
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
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(App).toMediator(AppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(MapView).toMediator(MapViewMediator);
			mediatorMap.map(LayerSelector).toMediator(LayerSelectorMediator);
			mediatorMap.map(CellInfoPanel).toMediator(CellInfoPanelMediator);
			mediatorMap.map(ControlPanel).toMediator(ControlPanelMediator);
			mediatorMap.map(MinigameView).toMediator(MinigameViewMediator);
			mediatorMap.map(SelectionLock).toMediator(SelectionLockMediator);
			//event
			eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			eventCommandMap.map(GameEvent.SCAN_RESULT, GameEvent).toCommand(ReportScanResultCommand);
			eventCommandMap.map(GameEvent.DELIVER_PROBE, GameEvent).toCommand(DeliverProbeCommand);
			eventCommandMap.map(SFSEvent.ROOM_VARIABLES_UPDATE, SFSEvent).toCommand(UpdateRoomVarsCommand);
			eventCommandMap.map(GameEvent.SELECT_CELL, GameEvent).toCommand(SelectCellCommand);
			eventCommandMap.map(GameEvent.SELECT_LAYER, GameEvent).toCommand(SelectLayerCommand);
			eventCommandMap.map(GameEvent.PING, GameEvent).toCommand(PingCommand);
			//Commands
			directCommandMap.map(commands.StartupCommand).execute();
		}
		
	}

}