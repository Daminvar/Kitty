package code.entities
{
	import code.*;
	
	public class SpicyTuna extends DynamicNPE
	{
		private var _level:Level;
		public function SpicyTuna(lvl:Level, xPos:Number, yPos:Number)
		{
			x = xPos;
			y = yPos;
			_level = lvl;
			_isCollidable = false;
		}
		
		public override function update(g:Logic):void
		{
		}
		
		public override function handleCollision(k:Kitty):void
		{
			k.setSpecial(FlamingHairball);
			_level.removeEntity(this);
		}

	}
	
}
