package code.entities 
{
	import code.*;
	
	public class LevelPortal extends DynamicNPE 
	{
		private var _level:Level;
		public function LevelPortal(xPos:Number, yPos:Number, howWide:Number, howTall:Number)
		{
			x = xPos;
			y = yPos;
			width = howWide;
			width = howTall;
			_isCollidable = true;
			showOutline();
		}
		
		public override function update():void
		{
			
		}
		
		public override function handleCollision(k:Kitty):void
		{
			trace("CHANGING LEVEL.....");
		}

	}
	
}
