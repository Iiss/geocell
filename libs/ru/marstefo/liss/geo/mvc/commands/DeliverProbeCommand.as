package ru.marstefo.liss.geo.mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class DeliverProbeCommand extends ExtensionCommand
	{
		public function DeliverProbeCommand() 
		{
			super("game.deliverProbe");
		}
	}
}