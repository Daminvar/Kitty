package code.entities
{
	import code.*;

	public class Rope extends DynamicNPE
	{
		private var _level:Level;

		public function Rope(lvl:Level, xPos:Number, yPos:Number,
			height:Number)
		{
			x = xPos;
			y = yPos;
			_level = lvl;
			this.height = height;
		}

		public override function update(g:Logic):void
		{
		}

		public override function handleHairball(h:Hairball):void
		{
			if (h is FlamingHairball && h.isColliding(this))
			{
				for(var i:Number = 0; i < _level.entities.length;i++)
				{
					if(_level.entities[i] is Can)
						(_level.entities[i] as Can).fall(450);
				}
				_level.removeEntity(this);
			}

			if (h.isColliding(this))
				h.kill();
		}
	}
}
