package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.net.*;

	public class Kitty extends GameEntity
	{
		var ACCELERATION:Number = 4;
		var SPEED:Number = 6;
		var ORIGINAL_VELOCITY:Number = 50;
		var gravity:Number = 0.2;
		var origY:Number;
		var velocity:Number;
		private var cooldown:int = 10;
		public var bulletManager:BulletManager;
		private var game:Logic;
		private var jumping:Boolean;
		private var falling:Boolean;

		public function Kitty(xCo:Number,yCo:Number,game:Logic)
		{
			x = xCo;
			y = yCo;
			velocity = ORIGINAL_VELOCITY;
			origY = yCo;
			bulletManager = new BulletManager(game,10,10,50);
			this.game = game;
			showOutline();
		}

		public function moveLeft()
		{
			x -=  SPEED;
		}

		public function moveRight()
		{
			x +=  SPEED;
		}

		public function jump()
		{
			
			addEventListener(Event.ENTER_FRAME, jumpProper);
		}

		public function jumpProper(e:Event)
		{
			if(!falling)
			{
			jumping = true;
			y -=  velocity;
			velocity -=  ACCELERATION;
			if(velocity <= 0){
				jumping = false;
				removeEventListener(Event.ENTER_FRAME, jumpProper);
			}
			}
/*			if (y > origY)
			{
				y = origY;
				removeEventListener(Event.ENTER_FRAME, jumpProper);
				velocity = ORIGINAL_VELOCITY;
				jumping = false;
			}*/

		}
		
		public function fall(){
			if(!game.getMap().isCollidingWithEnvironment(this) && !jumping){
				y+=velocity;
				velocity += ACCELERATION;
				trace("true");
				falling = true;
			}else{
				falling = false
				trace("false");
				if(!jumping)
					velocity = ORIGINAL_VELOCITY;
			}
		}

		public function fire():void
		{
			cooldown--;
			var mousePnt = localToGlobal(new Point(mouseX,mouseY));
			var dx:Number = mousePnt.x - x;
			var dy:Number = mousePnt.y - y;
			var angle:Number = Math.atan2(dy,dx) * 180 / Math.PI;
			trace(angle);
			if (bulletManager.fireBullet(new Point(this.x,this.y),angle))
			{
				cooldown = cooldown;
			}
		}
	}
}
