package code.entities
{
	import code.*
	public class HelpArrow extends DynamicNPE
	{
		public function HelpArrow(xPos:Number, yPos:Number, scaleX:Number, scaleY:Number, rotation:Number)
		{
			x = xPos;
			y = yPos;
			_isCollidable = false;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
			this.rotation = rotation;
		}
		
		public override function update(g:Logic):void
		{
		}
		
		public override function handleCollision(k:Kitty):void
		{
		}

	}
	
}
