package code.entities
{
	import code.*;
	
	public class Can extends DynamicNPE
	{
		private var RAISENUM:Number;
		private var MAXRAISE:Number;
		
		public function Can(xPos:Number, yPos:Number, max:Number)
		{
			trace("woot");
			this.x = xPos;
			this.y = yPos;
			RAISENUM = 10;
			MAXRAISE = max;
			_isCollidable = true;
		}
		
		public override function update():void
		{
		}
		
		public function lower()
		{
			this.y += RAISENUM;
		}
	}
}
