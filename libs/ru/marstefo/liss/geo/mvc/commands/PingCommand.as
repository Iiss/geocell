package mvc.commands 
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