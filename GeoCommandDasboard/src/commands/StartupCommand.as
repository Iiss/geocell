package commands 
{
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
	import ru.marstefo.liss.net.commands.LoadConfigCommand;
	import ru.marstefo.liss.net.commands.SFSConnectCommand;
	import ru.marstefo.liss.net.commands.SFSLoginCommand;
	import ru.marstefo.liss.net.commands.SFSJoinRoomCommand;
	import ru.marstefo.liss.geo.commands.SetupWikiCommand;
	import ru.marstefo.liss.geo.commands.SetupSessionCommand;
	
	public class StartupCommand extends SequenceMacro
	{
		override public function prepare():void 
		{
			add(SetupWikiCommand);
			add(LoadConfigCommand);
			add(SFSConnectCommand);
			add(SFSLoginCommand);
			add(SFSJoinRoomCommand);
		}	
	}
}