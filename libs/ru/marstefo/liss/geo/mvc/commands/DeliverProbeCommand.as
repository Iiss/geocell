package mvc.commands 
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