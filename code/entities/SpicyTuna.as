package  code.entities {
	import code.DynamicNPE;
	import code.Kitty;
	import code.FlamingHairball;
	
	public class SpicyTuna extends DynamicNPE{

		public function SpicyTuna(xPos:Number, yPos:Number) {
			// constructor code
			x = xPos;
			y = yPos;
		}
		
		public override function update():void
		{
			
		}
		
		public override function handleCollision(k:Kitty):void
		{
			k.setSpecial(FlamingHairball);
		}

	}
	
}
