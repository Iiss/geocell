package ru.marstefo.liss.geo.mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class PingCommand extends ExtensionCommand
	{
		public function PingCommand() 
		{
			super("game.ping");
		}
	}
}