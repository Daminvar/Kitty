package code
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	

	public class Hairball extends GameEntity
	{
		private var SPEED:Number = 20;

		public var age:int = 0;
		private var vx:Number;
		private var vy:Number;
		private var game:Logic;

		public function Hairball(game:Logic)
		{
			this.game = game;
		}

		public function fire(firingPosition:Point, travelRotation:Number):void
		{
			age = 0;
			x = firingPosition.x;
			y = firingPosition.y;
			rotation = travelRotation;
			vx = Math.cos(travelRotation * Math.PI / 180) * SPEED;
			vy = Math.sin(travelRotation * Math.PI / 180) * SPEED;
		}

		public function move():void
		{
			checkCollision();
			x +=  vx;
			y +=  vy;
		}
		
		public function checkCollision() {
			if(this.hitTestObject(game._skeletunaTest)){
				/* CLEAN UP NEEDS TO BE PROPERLY ADDED HERE!! */
				
			}
		}
	}
}
