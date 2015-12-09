package views.gameobjects 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	import com.greensock.TweenNano;
	import mx.core.UIComponent;
	import assets.swf.ScanProcessArt;
	import assets.swf.ScanTargetArt;
	import assets.swf.ScanMarkArt;
	import assets.swf.ScanWorkingArt;
	import ru.marstefo.liss.utils.ObjectPool;
	
	public class CellSelector extends UIComponent
	{
		private var _container:DisplayObjectContainer;
		private var _points:Vector.<ScanMarkArt>;
		private var _curMark:ScanMarkArt
		private var _pointer:ScanTargetArt;
		private var _working:ScanWorkingArt
		private var _scanProcess:ScanProcessArt;
		private var _moving:Boolean;
		private var _speed:Number = 220;
		
		public function CellSelector() 
		{
			_container = this;
			_pointer = new ScanTargetArt();
			_working = new ScanWorkingArt();
			_scanProcess = new ScanProcessArt();
			
			_scanProcess.visible = false;
			_working.visible = false;
			
			addChild(_pointer);
			addChild(_working);
			addChild(_scanProcess);
			
			_points = new Vector.<ScanMarkArt>();
		}
		
		public function addPoint(pt:Point):void
		{
			var art:ScanMarkArt = ObjectPool.create(ScanMarkArt) as ScanMarkArt;
			art.x = pt.x - .5 * art.width;
			art.y = pt.y - .5 * art.height;
			addChild(art);
			
			_points.push(art);
			
			if (!_moving)
				_moveToNext();
		}
		
		private function _moveToNext():void
		{
			_moving = true;
			_curMark = _points.shift();
			var pt:Point = new Point(_curMark.x + _curMark.width / 2, _curMark.y + _curMark.height / 2);
			var distance:Number = Math.sqrt(Math.pow(_pointer.x - pt.x, 2) + Math.pow(_pointer.y - pt.y, 2));
			var duration:Number = distance / _speed;
			TweenNano.to(_pointer, duration, { x:pt.x, y:pt.y,onComplete:_onMoveComplete});
		}
		
		private function _onMoveComplete():void
		{
			_container.removeChild(_curMark);
			ObjectPool.recycle(_curMark);
			
			_pointer.visible = false;
			
			_scanProcess.x = _curMark.x;
			_scanProcess.y = _curMark.y;
			_scanProcess.visible = true;
			
			_curMark = null;
			
			_working.visible = true;
			_working.x = _pointer.x;
			_working.y = _pointer.y;
			_working.gotoAndPlay(1);
			TweenNano.delayedCall(_working.totalFrames,_onProcessComplete,null,true)
		}
		
		private function _onProcessComplete():void
		{
			_pointer.visible = true;
			_scanProcess.visible = false;
			_working.visible = false;
			
			if (_points.length)
				_moveToNext();
			else
				_moving = false;
		}
		
		private function set state(stateName:String):void{}
	}
}