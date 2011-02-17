package code
{
	import flash.geom.*;

	public class FlamingHairball extends Hairball
	{
		private const ACCELERATION:int = 1;
		private const SPEED:int = 15;

		public function FlamingHairball(game:Logic)
		{
			super(game);
			_lifeSpan = 40;
		}

		public override function fire(firingPosition:Point,
			travelRotation:Number):void
		{
			_age = 0;
			x = firingPosition.x;
			y = firingPosition.y;
			rotation = travelRotation;
			_vx = Math.cos(travelRotation * Math.PI / 180) * SPEED;
			_vy = Math.sin(travelRotation * Math.PI / 180) * SPEED;
		}

		public override function update():void
		{
			_vy += ACCELERATION;
			super.update();
		}
	}
}
