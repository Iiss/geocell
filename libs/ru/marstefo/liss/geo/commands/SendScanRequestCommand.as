package ru.marstefo.liss.geo.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class SendScanRequestCommand extends ExtensionCommand
	{
		public function SendScanRequestCommand() 
		{
			super("game.scanRequest");
		}
		
		override public function execute():void 
		{
			super.execute();
		}
	}
}