package code {
	
	import flash.display.MovieClip;
	
	
	public class Skeletuna extends MovieClip {
		private var stepsLeft:Number;		// Current count of steps to the left
		private var stepsRight:Number;		// Current count of steps to the right
		private var moveSpeed:Number;
		private var maxStepsLeft:Number;
		private var maxStepsRight:Number;
		private var facing:String;			// Direction it is facing
		
		/*
			xInit -- Starting X-POS
			yInit -- Starting Y-POS
			moveSpeed -- Speed at which to move
			maxStepsLeft -- Number of steps to move left
			maxStepsRight -- Number of steps to move right
		*/
		public function Skeletuna(xInit:Number, yInit:Number, moveSpeed:Number, maxStepsLeft:Number, maxStepsRight:Number) {
			// constructor code
			this.x = xInit;
			this.y = yInit;
			this.moveSpeed = moveSpeed;
			this.maxStepsRight = maxStepsRight;
			this.maxStepsLeft = maxStepsLeft;
			stepsLeft = 0;
			stepsRight = 0;
			facing = "left";
		}
				
		public function pace(){
			
			if(facing == "left"){
				// Add to step count
				stepsLeft += 1;
				
				// Move position by speed
				x -= moveSpeed;
				
				
			}else if(facing == "right"){
				
				// Add to step count
				stepsRight += 1;
				
				// Move position by speed
				x += moveSpeed;
				
			}
			
			// Check if enemy reaches its last "step"
			if(stepsLeft >= maxStepsLeft){
				// Reaches last step -- reset step count and flip direction
				stepsLeft = 0;
				facing = "right";
				
				// Flip image to face right
				scaleX = -1;
			}else if(stepsRight>= maxStepsLeft){
				// Reaches last step -- reset step count and flip direction
				stepsRight = 0;
				facing = "left";
				
				// Flip image to face left
				scaleX = 1;
			}
			
			
		}
		
	}
	
}
