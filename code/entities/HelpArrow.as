package code.entities
{
	import code.*
	public class HelpArrow extends DynamicNPE
	{
		public function HelpArrow(xPos:Number, yPos:Number, wid:Number, hei:Number, scaleX:Number, scaleY:Number, rotation:Number)
		{
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
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