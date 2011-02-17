package code
{
	import flash.display.MovieClip;
	
	public class Can extends DynamicNPE
	{
		private var RAISENUM:Number;
		private var MAXRAISE:Number;
		
		public function Can(xPos:Number, yPos:Number, max:Number)
		{
			this.x = xPos;
			this.y = yPos;
			RAISENUM = 15;
			MAXRAISE = max;
			_isCollidable = true;
		}
		
		public override function update():void
		{
		}
		
		public function raise()
		{
			if(this.y > MAXRAISE)
				this.y -= RAISENUM;
		}
	}
}
