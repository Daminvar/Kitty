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
                        isCollidable = true;
		}

		public override function update():void
		{
		}

		public override function handleCollision(k:Kitty):void
		{
			k.kill();
		}
	}
}
