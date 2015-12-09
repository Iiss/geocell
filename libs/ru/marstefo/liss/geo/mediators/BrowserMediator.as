package ru.marstefo.liss.geo.mediators 
{
	import mvc.models.WikiConfig;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.components.Browser;
	
	public class BrowserMediator extends Mediator
	{
		[Inject]
		public var 	wikiConfig:WikiConfig;
		
		[Inject]
		public var view:Browser;
		
		public function BrowserMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			view.homeURL = view.htmlBox.location = wikiConfig.wikiURL;
		}
	}
}