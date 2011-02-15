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
		}

		public override function update():void
		{
		}
	}
}
