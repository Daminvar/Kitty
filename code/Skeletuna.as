package code {
	import flash.display.MovieClip;
	
	public class Skeletuna extends DynamicNPE
	{
		private const MOVE_SPEED = 6;

		private var _facing:String;
		private var _initialX:Number;
		private var _patrolWidth:Number;
		
		public function Skeletuna(xInit:Number, yInit:Number, patrolWidth:Number)
		{
			x = _initialX = xInit;
			y = yInit;
			_patrolWidth = patrolWidth;
			_facing = "right";
		}
				
		public override function update():void
		{
			if(_facing == "left")
				x -= MOVE_SPEED;
			else if(_facing == "right")
				x += MOVE_SPEED;
			
			if(x < _initialX)
			{
				_facing = "right";
				gotoAndStop("right");
			}
			else if(x + width > _initialX + _patrolWidth)
			{
				_facing = "left";
				gotoAndStop("left");
			}
		}
	}
}
