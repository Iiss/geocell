package mvc.commands 
{
	import mvc.models.WikiConfig;
	import ru.marstefo.liss.net.commands.LoadConfigCommand;
	
	public class SetupWikiCommand extends LoadConfigCommand 
	{
		private static const CONFIG_PATH:String = "config/wiki-config.xml";
		
		[Inject]
		public var wikiConfig:WikiConfig;
		
		public function SetupWikiCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			load(CONFIG_PATH);
		}
		
		override protected function onComplete(result:*):void 
		{
			var data:XML = new XML(result);
			wikiConfig.wikiURL = data.url.toString();
		}	
	}

}