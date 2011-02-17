package code
{
	import flash.geom.Point;

	public class BulletManager
	{
		private const MAX_BULLETS = 10;

		private var activeBullets:Vector.<Hairball> = new Vector.<Hairball>();
		public function get ActiveBullets():Vector.<Hairball>
		{
			return activeBullets;
		}
		private var game:Logic;

		public function BulletManager(aGame:Logic)
		{
			game = aGame;
		}

		public function fireBullet(BulletClass:Class, firingPosition:Point, travelRotation:Number):Boolean
		{
			if (activeBullets.length < MAX_BULLETS)
			{
				var bullet = new BulletClass(game);
				bullet.fire(firingPosition, travelRotation);
				activeBullets.push(bullet);
				game.addChild(bullet);
				return true;
			}
			return false;
		}

		public function update():void
		{
			for (var i:int = 0; i < activeBullets.length; i++)
			{
				var bullet:Hairball = (activeBullets[i] as Hairball);
				bullet.update();
				if (bullet.isDead)
				{
					killBullet(bullet, i);
					i--;
				}
			}
		}

		public function killAllBullets():void
		{
			for (var i = 0; i < activeBullets.length; i++)
			{
				killBullet(activeBullets[i], i);
			}
		}

		public function killBullet(b:Hairball, index:int):void
		{
			activeBullets.splice(index, 1);
			game.removeChild(b);
		}
	}
}
