package ru.marstefo.liss.net.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.SmartFox;
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.liss.geo.events.GameEvent;
	import ru.marstefo.liss.net.models.ConfigModel;
	/**
	 * ...
	 * @author liss
	 */
	public class ExtensionCommand extends Command
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var config:ConfigModel;
		
		[Inject]
		public var gameEvent:GameEvent;
		
		protected var _command:String;
		
		public function ExtensionCommand(cmd:String) 
		{
			_command = cmd;
			super()
		}
		
		override public function execute():void 
		{
			var room:Room = sfs.getRoomByName(config.room);
			var obj:SFSObject = SFSObject.newFromObject(gameEvent.data);
			var req:ExtensionRequest = new ExtensionRequest(_command, obj, room);
			_addListeners();
			sfs.send(req);
		}
		
		private function _onResponse(e:SFSEvent):void
		{
			_removeListeners()
		};
		
		private function _addListeners():void 
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, _onResponse);
		}
		
		private function _removeListeners():void
		{
			sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, _onResponse);
		}	
	}
}