package code.entities
{
	import code.*;
	import flashx.textLayout.formats.LeadingModel;
	
	public class Cog extends DynamicNPE
	{
		private var _level:Level;
		public function Cog(xPos:Number, yPos:Number, lev:Level)
		{
			x = xPos;
			y = yPos;
			_isCollidable = false;    
			_level = lev;
		}

		public override function update(g:Logic):void
		{
		}
		
		public override function handleHairball(h:Hairball):void
		{
			if (h.isColliding(this))
			{
				for(var i:Number = 0; i < _level.entities.length;i++)
				{
					if(_level.entities[i] is Can)
					{
						(_level.entities[i] as Can).lower();
						h.kill();
					}
				}
			}
		}
	}
}
