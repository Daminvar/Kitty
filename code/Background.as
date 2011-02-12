﻿package code {
	import flash.display.MovieClip;
	
	/* Class to create a background to scroll
		Add objects to the background so that they can all be updated simultaneously to "scroll"
	*/
	public class Background extends MovieClip {
		
		private var objectArray:Array;	// Container to hold background objects
		private var background_mc:GameEntity;
		private var foreground_mc:GameEntity;
		private var objectLayer_mc:GameEntity;
		
		public function Background() {
			// constructor code
			objectArray = new Array();
			background_mc = new GameEntity();
			foreground_mc = new GameEntity();
			objectLayer_mc = new GameEntity();
		}
		
		public function getBackground(){
			return background_mc;
		}
		
		
		
		public function getForeground(){
			return foreground_mc;
		}
		
		public function getObjectLayer(){
			return objectLayer_mc;
		}
		
		/*
			Adds movieclip to the background "layer"
			Object--Movieclip object to add
		*/
		public function addToBackground(object:GameEntity){
			//objectArray.push(object);
			background_mc.addChild(object);
		}
		
		public function addToForeground(object:GameEntity){
			foreground_mc.addChild(object);
		}
		
		public function addToObjectLayer(object:GameEntity){
			objectLayer_mc.addChild(object);
		}
		
		/*
			This function updates (moves) the background
			dir -- Direction kitty should move
			speed -- Speed kitty is moving
		*/
		public function update(dir:String, speed:Number){
			if(dir == "left"){
				background_mc.x += speed;
				foreground_mc.x += speed;
				objectLayer_mc.x += speed;
			}else if(dir == "right"){
				background_mc.x -= speed;
				foreground_mc.x -= speed;
				objectLayer_mc.x -= speed;
			}
		
		}

	}
	
}
