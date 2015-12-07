package ru.marstefo.liss.geo.mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class RemovePlantCommand extends ExtensionCommand
	{
		
		public function RemovePlantCommand() 
		{
			super("game.removePlant");
		}
		
	}

}