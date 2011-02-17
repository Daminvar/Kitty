package code.entities 
{
	import code.*;
	
	public class LevelPortal extends DynamicNPE 
	{
		private var _level:Level;
		public function LevelPortal(xPos:Number, yPos:Number, width:Number, height:Number)
		{
			x = xPos;
			y = yPos;
			this.width = width;
			this.height = height;
			_isCollidable = false;
		}
		
		public override function update():void
		{
		}
		
		public override function handleCollision(k:Kitty):void
		{
			// PUT SOME CODE HERE 
		}

	}
	
}
