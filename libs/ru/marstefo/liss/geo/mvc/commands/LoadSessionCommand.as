package ru.marstefo.liss.geo.mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	import ru.marstefo.liss.utils.LogService;
	
	public class LoadSessionCommand extends ExtensionCommand 
	{
		import ru.marstefo.liss.net.commands.ExtensionCommand;
		
		[Inject]
		public var logger:LogService;
		
		public function LoadSessionCommand() 
		{
			super("game.load");
		}
		
		override public function execute():void 
		{
			logger.log('Load new session')
			
			if (!gameEvent.data.id)
			{
				_command = "game.next";	
			}
			
			super.execute();
		}
	}
}