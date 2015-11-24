package mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class SendScanRequestCommand extends ExtensionCommand
	{
		public function SendScanRequestCommand() 
		{
			super("game.scanRequest");
		}
	}
}