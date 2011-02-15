package code
{
	import flash.display.MovieClip;
	
	public class CogTrigger extends GameEntity
	{
		public function CogTrigger(xPos:Number, yPos:Number)
		{
			x = xPos;
			y = yPos;
		}
		
		public function rotate()
		{
			if(rotation <= 40)
				this.rotation -= 10;
		}
	}
}
