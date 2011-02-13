package code {
	
	import flash.display.MovieClip;
	
	
	public class CogTrigger extends GameEntity {
		
		
		public function CogTrigger(xPos:Number, yPos:Number) {
			// constructor code
			this.x = xPos;
			this.y = yPos;
		}
		
		public function rotate(){
			this.rotation -= 10;
			
		}
	}
	
}
