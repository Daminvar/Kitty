package code
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	

	public class Hairball extends GameEntity
	{
		private const SPEED:Number = 20;

		protected var _age:int;
		protected var _isDead:Boolean;
		protected var _lifeSpan:int;
		protected var _vx:Number;
		protected var _vy:Number;
		protected var _game:Logic;

		public function get age():int
		{
			return _age;
		}

		public function get isDead():Boolean
		{
			return _isDead;
		}

		public function kill():void
		{
			_isDead = true;
		}

		public function Hairball(game:Logic)
		{
			_game = game;
			_lifeSpan = 20;
		}

		public function fire(firingPosition:Point, travelRotation:Number):void
		{
			_age = 0;
			x = firingPosition.x;
			y = firingPosition.y;
			rotation = travelRotation;
			_vx = Math.cos(travelRotation * Math.PI / 180) * SPEED;
			_vy = Math.sin(travelRotation * Math.PI / 180) * SPEED;
		}

		public function update():void
		{
			_age++
			if (_age > _lifeSpan)
				_isDead = true;
			x +=  _vx;
			y +=  _vy;
		}
	}
}
