package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.net.*;

	public class Kitty extends GameEntity
	{
		const ACCELERATION:Number = 2.5;
		const GRAVITY:Number = 0.2;
		const ORIGINAL_VELOCITY:Number = 25;
		const SPEED:Number = 5;

		private var _velocity:Number;
		private var _bulletManager:BulletManager;
		private var _cooldown:Number;
		private var _game:Logic;
		private var _jumping:Boolean;
		private var _falling:Boolean;
		private var _dead:Boolean;
		private var _moveBuffer:Number;
		private var _maxMoveBuffer:Number;
		private var _canMove:Boolean;
		private var _canMoveLeft:Number;
		private var _canMoveRight:Number;

		public function get bulletManager():BulletManager
		{
			return _bulletManager;
		}

		public function Kitty(xPos:Number, yPos:Number, game:Logic)
		{
			x = xPos;
			y = yPos;
			_velocity = ORIGINAL_VELOCITY;
			_bulletManager = new BulletManager(game,10,10,50);
			_game = game;
			showOutline();
			_dead = false;
			_moveBuffer = 0;
			_canMove = true;
			_canMoveLeft =0;
			_canMoveRight = 0;
			_maxMoveBuffer = 64;

			onRemoved(function() {
				_bulletManager.killAllBullets();
			});
		}
		
		public function isDead():Boolean
		{
			return _dead;
		}
		
		public function canLeft():Boolean
		{
			return _canMoveLeft <= _maxMoveBuffer;
		}

		public function canRight():Boolean
		{
			return _canMoveRight <= _maxMoveBuffer;
		}

		public function moveLeft():void
		{
			if (!_game.getLevel().isCollidingWithEnvironment(this))
			{
				x -=  SPEED;
				_canMoveLeft += SPEED;
				_canMoveRight -= SPEED;
				
				while(_game.getLevel().isCollidingWithEnvironment(this))
				{
					x +=  1;
					_canMoveLeft -= 1;
					_canMoveRight += 1;
				}
			}
		}

		public function moveRight():void
		{
			if (!_game.getLevel().isCollidingWithEnvironment(this))
			{
				x +=  SPEED;
				_canMoveLeft -= SPEED;
				_canMoveRight += SPEED;
				
				while(_game.getLevel().isCollidingWithEnvironment(this))
				{
					x -=  1;
					_canMoveLeft += 1;
					_canMoveRight -= 1;
				}
			}

		}

		public function jump()
		{
			
			addEventListener(Event.ENTER_FRAME, jumpProper);
		}

		private function jumpProper(e:Event)
		{

			if (!_game.getLevel().isCollidingWithEnvironment(this) &&
				!_falling)
			{
				_jumping = true;
				y -=  _velocity;
				_velocity -=  ACCELERATION;
				while(_game.getLevel().isCollidingWithEnvironment(this))
				{
					y += 1;
					_jumping = false;
				}
				if(_velocity <= 0)
				{
					_jumping = false;
					removeEventListener(Event.ENTER_FRAME, jumpProper);
				}
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, jumpProper);
			}

		}
		
		public function kill():void
		{
			_dead = true;
		}

		public function fireHairball():void
		{
			_cooldown--;
			var mousePnt = localToGlobal(new Point(mouseX,mouseY));
			var dx:Number = mousePnt.x - x;
			var dy:Number = mousePnt.y - y;
			var angle:Number = Math.atan2(dy,dx) * 180 / Math.PI;
			bulletManager.fireBullet(new Point(this.x, this.y), angle)
		}

		public function fireSpecial():void
		{
		}
		
		public function update():void
		{
			fall();
			_bulletManager.update();
		}

		private function fall():void
		{
			var colliding = _game.getLevel().isCollidingWithEnvironment(this);
			if (colliding)
			{
				for each(var d:DynamicNPE in _game.getLevel().entities)
				{
					if (d.isColliding(this))
						d.handleCollision(this);
				}
			}
			if (!colliding && !_jumping)
			{
				_falling = true;
				y += _velocity;
				while (_game.getLevel().isCollidingWithEnvironment(this))
				{
					y -= 1;
					_falling = false;
				}
				
				if (_velocity < 30) //Velocity cap for collision
					_velocity += ACCELERATION;
				
				if (y > stage.stageHeight + 10)
				{
					_falling = false;
					_dead = true;
				}
			}
			else
			{
				_falling = false;
				if (!_jumping)
					_velocity = ORIGINAL_VELOCITY;
			}
		}

		public override function isColliding(e:GameEntity):Boolean
		{
			return this.hitTestObject(e);
		}
	}
}
