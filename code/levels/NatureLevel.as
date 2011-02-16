package code.levels
{
	import flash.geom.*;

	import code.*;
	import code.entities.*;

	public class NatureLevel extends Level
	{
		[Embed(source="../../res/testmap.tmx",
			mimeType="application/octet-stream")]
		private static const _Map:Class;

		public function NatureLevel(
			backgroundLayer:GameEntity,
			objectLayer:GameEntity,
			foregroundLayer:GameEntity,
			parallaxTarget:GameEntity)
		{
			parallaxTarget.addChild(new MossyBG());
			super(_Map, backgroundLayer, objectLayer, foregroundLayer);
		}

		protected override function register(entityName:String, rect:Rectangle):void
		{
			if (entityName == "skeletuna")
				addToEntityVectorAndStage(new Skeletuna(this, rect.x, rect.y,
					rect.width));
			if (entityName == "saw")
				addToEntityVectorAndStage(new Saw(rect.x, rect.y, rect.width,
					rect.height));
			if (entityName == "spicyTuna")
				addToEntityVectorAndStage(new SpicyTuna(rect.x, rect.y));
		}
	}
}
