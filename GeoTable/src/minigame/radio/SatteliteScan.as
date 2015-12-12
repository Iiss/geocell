package minigame.radio 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import minigame.base.MinigameFieldBase;
	import minigame.Minigame;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import assets.BenderFont;
	
	public class SatteliteScan extends MinigameFieldBase 
	{
		private static var COOLDOWN:int = 30000;//ms
		private static var LAST_CALL:Number;
		
		private var _statusTxt:TextField;
		private var _btn:ScanButton;
		
		public function SatteliteScan(gameState:*, accessories:Minigame)
		{
			_btn = new ScanButton(gameState.cellWidth * 3, gameState.cellHeight * 3);
			_btn.mouseEnabled = false;
			_btn.mouseChildren = false;
			rightElement = 0;
			
			_statusTxt = new TextField();
			var tf:TextFormat = new TextFormat(new BenderFont().fontName, 7, 0);
			tf.align = 'center';
			tf.bold = true;
			_statusTxt.background = true;
			_statusTxt.backgroundColor = 0xFFFAE5;
			_statusTxt.defaultTextFormat = tf;
			_statusTxt.embedFonts = true;
			_statusTxt.width = gameState.cellWidth * 3;
			_statusTxt.height = gameState.cellHeight / 2;
			_statusTxt.y=gameState.cellHeight * 2.5;
			
			_checkStatus();

			addChild(_statusTxt);
			addChild(_btn);
			
			super(accessories);
		}
		
		override protected function finishWin():void 
		{
			LAST_CALL = new Date().getTime();
			trace(LAST_CALL);
			super.finishWin();
		}
		
		override protected function onTimer(event:TimerEvent):void 
		{
			_checkStatus()
		}
		
		private function _checkStatus():void
		{
			var now:Number = new Date().getTime();
			
			if (isNaN(LAST_CALL) || ((now - LAST_CALL) > COOLDOWN))
			{
				_btn.mouseEnabled = true;
				_btn.alpha = 1;
				_statusTxt.text = "ГОТОВ";
			}
			else
			{
				_btn.mouseEnabled = false;
				_btn.alpha = .6;
				_statusTxt.text = getFormat(COOLDOWN-now + LAST_CALL);
			}
		}
		
		private function getFormat(ms:Number):String
		{
			if (ms < 0) ms = 0;
			var min:Number = Math.floor(ms / 60000);
			var sec:Number = Math.floor((ms % 60000)/1000);
			var minStr:String = min > 9 ? min.toString(): "0" + min.toString();
			var secStr:String = sec > 9 ? sec.toString() : "0" + sec.toString();
			return minStr + ' : ' + secStr;
		}
	}
}