package ru.marstefo.liss.geo.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.liss.geo.models.SessionModel;
	/**
	 * ...
	 * @author liss
	 */
	public class UpdateRoomVarsCommand extends Command
	{
		[Inject]
		public var event:SFSEvent;
		
		[Inject]
		public var sessionModel:SessionModel;
		
		public function UpdateRoomVarsCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			super.execute();
			sessionModel.updateRoomVars(event.params.changedVars);
		}	
	}
}