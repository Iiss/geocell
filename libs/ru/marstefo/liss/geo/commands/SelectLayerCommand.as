package ru.marstefo.liss.geo.commands 
{
	import ru.marstefo.liss.geo.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.liss.geo.events.GameEvent;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SelectLayerCommand extends Command 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var gameEvent:GameEvent;
		
		public function SelectLayerCommand() 
		{
			super()
		}
		
		override public function execute():void 
		{
			super.execute();
			if (!sessionModel.layers) return;
			
			var ind:int = gameEvent.data.layerIndex;
			if (ind < 0 || ind >= sessionModel.layers.length) return;
			
			sessionModel.currentLayer = sessionModel.layers[ind];
		}
		
	}

}