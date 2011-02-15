package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.net.*;

	public class Kitty extends GameEntity
	{
		var ACCELERATION:Number = 2.5;
		var SPEED:Number = 5;
		var ORIGINAL_VELOCITY:Number = 25;
		var gravity:Number = 0.2;
		var origY:Number;
		var velocity:Number;
		private var cooldown:int = 10;
		public var bulletManager:BulletManager;
		private var game:Logic;
		private var jumping:Boolean;
		private var falling:Boolean;
		private var dead:Boolean;
		private var moveBuffer:Number;
		private var maxMoveBuffer:Number;
		var canMove:Boolean;
		var canMoveLeft:Number;
		var canMoveRight:Number;

		public function Kitty(xCo:Number,yCo:Number,game:Logic)
		{
			x = xCo;
			y = yCo;
			velocity = ORIGINAL_VELOCITY;
			origY = yCo;
			bulletManager = new BulletManager(game,10,10,50);
			this.game = game;
			showOutline();
			dead = false;
			moveBuffer = 0;
			canMove = true;
			canMoveLeft =0;
			canMoveRight = 0;
			maxMoveBuffer = 64;

			onRemoved(function() {
				bulletManager.killAllBullets();
			});
		}
		
		public function isDead():Boolean
		{
			return dead;
		}
		
		public function canLeft():Boolean
		{
			return canMoveLeft <= maxMoveBuffer;
		}

		public function canRight():Boolean
		{
			return canMoveRight <= maxMoveBuffer;
		}

		public function moveLeft():void
		{
				x -=  SPEED;
				canMoveLeft += SPEED;
				canMoveRight -= SPEED;
		}

		public function moveRight():void
		{
				x +=  SPEED;
				canMoveLeft -= SPEED;
				canMoveRight += SPEED;
		}

		public function jump()
		{
			
			addEventListener(Event.ENTER_FRAME, jumpProper);
		}

		private function jumpProper(e:Event)
		{

			if (!game.getMap().isCollidingWithEnvironment(this) && !falling)
			{
				jumping = true;
				y -=  velocity;
				velocity -=  ACCELERATION;
				while(game.getMap().isCollidingWithEnvironment(this))
				{
					y += 1;
					jumping = false;
				}
				if(velocity <= 0)
				{
					jumping = false;
					removeEventListener(Event.ENTER_FRAME, jumpProper);
				}
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, jumpProper);
			}

		}

		public function fireHairball():void
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

		public function fireSpecial():void
		{
		}
		
		public function update():void
		{
			fall();
			bulletManager.update();
		}

		private function fall():void
		{
	
			if (!game.getMap().isCollidingWithEnvironment(this) && !jumping)
			{
				falling = true;
				y+=velocity;
				while(game.getMap().isCollidingWithEnvironment(this))
				{
					y -= 1;
					falling = false;
				}
				
				if(velocity < 30)				//Velocity cap for collision
					velocity += ACCELERATION;
				
				if (y > stage.stageHeight+10)
				{
					falling = false;
					dead = true;
				}
			}
			else
			{
				falling = false;
				if(!jumping)
					velocity = ORIGINAL_VELOCITY;
			}
		}

		public override function isColliding(e:GameEntity):Boolean
		{
			return this.hitTestObject(e);
		}
	}
}
