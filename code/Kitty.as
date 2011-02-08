package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.media.*;
	
	public class Kitty extends MovieClip{
	
        var ACCELERATION:Number = 4;
		var SPEED:Number = 6;
        var ORIGINAL_VELOCITY:Number = 50;

		var origY:Number;
		var velocity:Number;
		
		public function Kitty(xCo:Number, yCo:Number)
		{
			x = xCo;
			y = yCo;
			origY = yCo;
            velocity = ORIGINAL_VELOCITY;
		}
		
		public function moveLeft()
		{
			x -= SPEED;
		}
		
		public function moveRight()
		{
			x += SPEED;
		}
		
		public function jump()
		{
			addEventListener(Event.ENTER_FRAME, jumpProper);
		}
		
		public function jumpProper(e:Event)
		{
			y -= velocity;
			velocity -= ACCELERATION;
			if(y > origY)
			{
				y = origY;
				removeEventListener(Event.ENTER_FRAME, jumpProper);
                velocity = ORIGINAL_VELOCITY;
			}
			
		}
	}
}
