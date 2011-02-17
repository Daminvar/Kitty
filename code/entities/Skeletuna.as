package code.entities
{
	import flash.display.MovieClip;

	import code.*;
	
	public class Skeletuna extends DynamicNPE
	{
		private const MOVE_SPEED = 6;

		private var _facing:String;
		private var _initialX:Number;
		private var _level:Level;
		private var _patrolWidth:Number;
		
		public function Skeletuna(lvl:Level, xInit:Number, yInit:Number,
			patrolWidth:Number)
		{
			x = _initialX = xInit;
			y = yInit;
			_facing = "right";
			_level = lvl;
			_patrolWidth = patrolWidth;
			_isCollidable = true;
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

		public override function handleHairball(h:Hairball):void
		{
			if (h.isColliding(this))
			{
				_level.removeEntity(this);
				h.kill();
			}
		}

		public override function handleCollision(k:Kitty):void
		{
			k.kill();
		}
	}
}
