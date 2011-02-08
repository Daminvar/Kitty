package code
{
    import flash.geom.Point;

    public class BulletManager
    {
        private var allBullets:Array = new Array();
        private var activeBullets:Array = new Array();
        public function get ActiveBullets():Array {return activeBullets;}
        private var pooledBullets:Array = new Array();
        private var game:Logic;
        private var speed:Number;
        public function get Speed():Number {return speed;}
        private var lifespan:int;

        public function BulletManager(aGame:Logic, aSize:int, aSpeed:Number, aLifetime:int)
        {
            game = aGame;
            speed = aSpeed;
            lifespan = aLifetime;

            for (var i:int = 0; i < aSize; i++)
            {
                var bullet:Hairball = new Hairball();
                allBullets.push(bullet);
            }

            pooledBullets = allBullets.concat();
        }

        public function fireBullet(firingPosition:Point, travelRotation:Number):Boolean
        {
            if (pooledBullets.length > 0)
            {
                var bullet:Hairball = pooledBullets.pop();
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
                bullet.move()
                bullet.age++;
                if (bullet.age == lifespan)
                {
                    killBullet(bullet, i);
                    i--;
                }
            }
        }

        public function killBullet(b:Hairball, index:int):void
        {
            activeBullets.splice(index, 1);
            pooledBullets.push(b);
            game.removeChild(b);
        }
    }
}
