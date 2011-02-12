package code {
	import flash.display.MovieClip;
	
	/* Class to create a background to scroll
		Add objects to the background so that they can all be updated simultaneously to "scroll"
	*/
	public class Background extends MovieClip {
		
		private var objectArray:Array;	// Container to hold background objects
		private var background_mc:MovieClip;
		
		public function Background() {
			// constructor code
			objectArray = new Array();
			background_mc = new MovieClip();
			
		}
		
		public function getBackground(){
			return background_mc;
		}
		
		/*
			Adds movieclip to the background "layer"
			Object--Movieclip object to add
		*/
		public function addToBackground(object:MovieClip){
			//objectArray.push(object);
			background_mc.addChild(object);
		}
		
		/*
			This function updates (moves) the background
			dir -- Direction kitty should move
			speed -- Speed kitty is moving
		*/
		public function update(dir:String, speed:Number){
			//for each(var object:MovieClip in objectArray){
				if(dir == "left"){
					//object.x += speed;
					background_mc.x += speed;

				}else if(dir == "right"){
					//object.x -= speed;
					background_mc.x -= speed;
				}
			//}
			
		}

	}
	
}
