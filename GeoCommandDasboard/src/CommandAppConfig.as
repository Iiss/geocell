package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import ru.marstefo.liss.geo.commands.SelectCellCommand;
	import ru.marstefo.liss.geo.commands.SelectLayerCommand;
	import ru.marstefo.liss.geo.commands.StartupCommand;
	import mediators.CommandControlPanelMediator;
	import ru.marstefo.liss.geo.mediators.MapViewMediator;
	import ru.marstefo.liss.geo.models.SessionEvent;
	import ru.marstefo.liss.geo.models.SessionModel;
	import ru.marstefo.liss.geo.views.components.CellInfoPanel;
	import ru.marstefo.liss.geo.views.components.LayerSelector;
	import ru.marstefo.liss.geo.views.MapView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.commands.PingCommand;
	import commands.PlacePlantCommand;
	import commands.RemovePlantCommand;
	import ru.marstefo.liss.geo.commands.SetupSessionCommand;
	import ru.marstefo.liss.geo.commands.UpdateRoomVarsCommand;
	import ru.marstefo.liss.geo.events.GameEvent;
	import ru.marstefo.liss.geo.views.ConsoleView;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	import ru.marstefo.liss.geo.models.WikiConfig;
	import ru.marstefo.liss.geo.mediators.BrowserMediator;
	import ru.marstefo.liss.geo.views.components.Browser;
	import views.components.CommandControlPanel;
	import mediators.CommandControlPanelMediator;
	import ru.marstefo.liss.geo.mediators.ConsoleMediator;
	import ru.marstefo.liss.geo.mediators.LayerSelectorMediator;
	import ru.marstefo.liss.geo.mediators.CellInfoPanelMediator;
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