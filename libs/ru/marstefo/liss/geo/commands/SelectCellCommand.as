package ru.marstefo.liss.geo.commands 
{
	import ru.marstefo.liss.geo.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.liss.geo.events.GameEvent;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SelectCellCommand extends Command 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var gameEvent:GameEvent;
		
		public function SelectCellCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			super.execute();
			if (!sessionModel.cells) return;
			
			var ind:int = gameEvent.data.x + gameEvent.data.y * sessionModel.mapInfo.width;
			if (ind < 0 || ind >= sessionModel.cells.length) return;
			if (sessionModel.cells[ind].walkable)
				sessionModel.currentCell = sessionModel.cells[ind];	
		}
	}

}