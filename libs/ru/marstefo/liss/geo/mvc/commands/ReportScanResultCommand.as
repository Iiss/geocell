package mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class ReportScanResultCommand extends ExtensionCommand
	{
		public function ReportScanResultCommand() 
		{
			super("game.scan");
		}
	}
}