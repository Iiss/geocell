package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import mvc.commands.SelectCellCommand;
	import mvc.commands.SelectLayerCommand;
	import mvc.commands.StartupCommand;
	import mvc.mediators.*;
	import mvc.mediators.MapViewMediator;
	import mvc.mediators.SelectionLockMediator;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.components.AnalyticControlPanel;
	import mvc.views.components.CellInfoPanel;
	import mvc.views.components.LayerSelector;
	import mvc.views.components.SelectionLock;
	import mvc.views.MapView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.geo.mvc.commands.AssignProbeCommand;
	import ru.marstefo.liss.geo.mvc.commands.DeliverProbeCommand;
	import ru.marstefo.liss.geo.mvc.commands.PingCommand;
	import ru.marstefo.liss.geo.mvc.commands.PlacePlantCommand;
	import ru.marstefo.liss.geo.mvc.commands.RemovePlantCommand;
	import ru.marstefo.liss.geo.mvc.commands.ReportScanResultCommand;
	import ru.marstefo.liss.geo.mvc.commands.SendScanRequestCommand;
	import ru.marstefo.liss.geo.mvc.commands.SetupSessionCommand;
	import ru.marstefo.liss.geo.mvc.commands.UpdateRoomVarsCommand;
	import ru.marstefo.liss.geo.mvc.events.GameEvent;
	import ru.marstefo.liss.geo.mvc.views.ConsoleView;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	import mvc.models.WikiConfig;
	import mvc.mediators.BrowserMediator;
	import mvc.views.components.Browser;
	import mvc.views.components.CommandControlPanel;
	import mvc.views.mediators.CommandControlPanelMediator;
	/**
	 * ...
	 * @author liss
	 */
	public class CommandAppConfig implements IConfig
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
		
		public function CommandAppConfig() 
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
			mediatorMap.map(CommandApp).toMediator(CommandAppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(MapView).toMediator(MapViewMediator);
			mediatorMap.map(LayerSelector).toMediator(LayerSelectorMediator);
			mediatorMap.map(CellInfoPanel).toMediator(CellInfoPanelMediator);
			mediatorMap.map(CommandControlPanel).toMediator(CommandControlPanelMediator);
			//event
			eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			eventCommandMap.map(SFSEvent.ROOM_VARIABLES_UPDATE, SFSEvent).toCommand(UpdateRoomVarsCommand);
			eventCommandMap.map(GameEvent.SELECT_CELL, GameEvent).toCommand(SelectCellCommand);
			eventCommandMap.map(GameEvent.SELECT_LAYER, GameEvent).toCommand(SelectLayerCommand);
			eventCommandMap.map(GameEvent.PING, GameEvent).toCommand(PingCommand);
			eventCommandMap.map(GameEvent.PLACE_PLANT, GameEvent).toCommand(PlacePlantCommand);
			eventCommandMap.map(GameEvent.REMOVE_PLANT, GameEvent).toCommand(RemovePlantCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}