package code
{
	import flash.display.MovieClip;
	
	public class Can extends GameEntity
	{
		private var RAISENUM:Number;
		private var MAXRAISE:Number;
		
		public function Can(xPos:Number, yPos:Number, max:Number)
		{
			this.x = xPos;
			this.y = yPos;
			RAISENUM = 15;
			MAXRAISE = max;
		}
		
		public function raise()
		{
			if(this.y > MAXRAISE)
				this.y -= RAISENUM;
		}
	}
}
