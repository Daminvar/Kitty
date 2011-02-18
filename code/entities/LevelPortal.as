package code.entities 
{
	import code.*;
	
	public class LevelPortal extends DynamicNPE 
	{
		private var _game:Logic;
		public function LevelPortal(xPos:Number, yPos:Number, width:Number, height:Number)
		{
			x = xPos;
			y = yPos;
			this.width = width;
			this.height = height;
			_isCollidable = false;
		}
		
		public override function update(g:Logic):void
		{
			_game = g;
		}
		
		public override function handleCollision(k:Kitty):void
		{
			_game.changeLevel();
		}

	}
	
}
