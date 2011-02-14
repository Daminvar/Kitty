package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.net.*;

	public class Kitty extends GameEntity
	{
		var ACCELERATION:Number = 3;
		var SPEED:Number = 6;
		var ORIGINAL_VELOCITY:Number = 30;
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
		}
	
		public function isDead()
		{
			return dead;
		}
		
		public function canLeft():Boolean{
			if(canMoveLeft > maxMoveBuffer)
				return false;
			else
				return true;
			
		}
		public function canRight():Boolean{
			if(canMoveRight > maxMoveBuffer)
				return false;
			else
				return true;
			
		}
		

		public function moveLeft()
		{
			
				x -=  SPEED;
				canMoveLeft += SPEED;
				canMoveRight -= SPEED;
			
			
		}

		public function moveRight()
		{
				x +=  SPEED;
				canMoveLeft -= SPEED;
				canMoveRight += SPEED;
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
			}else {
				removeEventListener(Event.ENTER_FRAME, jumpProper);
			}

		}
		
		public function fall(){
			if(!game.getMap().isCollidingWithEnvironment(this) && !jumping){
				y+=velocity;
				velocity += ACCELERATION;
				falling = true;
				if(y > stage.stageHeight+10){
					trace("KITTY HAZ DIED!");
					falling = false;
					dead = true;
				}
			}else{
				falling = false;
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
