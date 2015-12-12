package minigame.radio 
{
	import flash.display.Bitmap;
	import minigame.base.MinigameElementBase;
	
	/**
	 * ...
	 * @author liss
	 */
	public class ScanButton extends MinigameElementBase 
	{
		[Embed(source = "../assets/satellite-icon.png")]
		private var Img:Class;
		public function ScanButton(w:Number,h:Number) 
		{
			super(0);
			graphics.clear();
			graphics.beginFill(0xFF0000,0);
			graphics.drawRect(0,0, w, h);
			graphics.endFill();
			
			var icon:Bitmap = new Img() as Bitmap;
			icon.smoothing = true;
			icon.scaleX = icon.scaleY = .4;
			icon.x = .5 * (w - icon.width);
			icon.y = .3 * (h - icon.height);
			addChild(icon);
		}
		
		override public function showRight(callback:Function):void
		{
			callback();
		}		
	}
}