package mvc.commands 
{
	import ru.marstefo.liss.net.commands.ExtensionCommand;
	
	public class AssignProbeCommand extends ExtensionCommand
	{
		public function AssignProbeCommand() 
		{
			super("game.assignProbe");
		}
		override public function execute():void 
		{
			trace('===\n\n' + gameEvent.data.probe_id, gameEvent.data.kern_id + '\n\n===');
			super.execute();
		}
	}
}