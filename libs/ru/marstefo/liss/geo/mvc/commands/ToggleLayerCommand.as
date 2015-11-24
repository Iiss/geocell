package ru.marstefo.liss.geo.mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class ToggleLayerCommand extends ExtensionCommand
	{
		public function ToggleLayerCommand() 
		{
			super("game.toggleLayer")
		}
	}
}