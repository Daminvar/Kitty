package code.entities
{
	import code.*;
	
	public class Can extends DynamicNPE
	{
		private var RAISENUM:Number;
		
		public function Can(xPos:Number, yPos:Number, width:Number,
			height:Number)
		{
			trace("woot");
			this.x = xPos;
			this.y = yPos;
			this.width = width;
			this.height = height;
			RAISENUM = 10;
			_isCollidable = true;
		}
		
		public override function update(g:Logic):void
		{
		}
		
		public function lower()
		{
			this.y += RAISENUM;
		}
	}
}
