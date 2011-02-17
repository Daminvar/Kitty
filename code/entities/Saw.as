package code.entities
{
	import code.*;

	public class Saw extends DynamicNPE
	{
		public function Saw(xPos:Number, yPos:Number, width:Number,
			height:Number)
		{
			x = xPos;
			y = yPos;
			this.width = width;
			this.height = height;
			_isCollidable = true;
		}

		public override function update():void
		{
		}

		public override function handleHairball(h:Hairball):void
		{
			if (h.isColliding(this))
				h.kill();
		}

		public override function handleCollision(k:Kitty):void
		{
			k.kill();
		}
	}
}
