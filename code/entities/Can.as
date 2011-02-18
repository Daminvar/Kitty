package code.entities
{
	import flash.events.*;

	import code.*;
	
	public class Can extends DynamicNPE
	{
		public function Can(xPos:Number, yPos:Number, width:Number,
			height:Number)
		{
			this.x = xPos;
			this.y = yPos;
			this.width = width;
			this.height = height;
			_isCollidable = true;
		}
		
		public override function update(g:Logic):void
		{
		}

		public function fall(limit:Number):void
		{
			addEvent(Event.ENTER_FRAME, function(e:Event) {
				y += 10;
				if (y >= limit)
					removeEventListener(Event.ENTER_FRAME, arguments.callee);
			});
		}
	}
}
