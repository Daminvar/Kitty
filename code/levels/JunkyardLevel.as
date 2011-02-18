package code.levels
{
	import flash.geom.*;

	import code.*;
	import code.entities.*;

	public class JunkyardLevel extends Level
	{
		[Embed(source="../../res/junkyard.tmx",
			mimeType="application/octet-stream")]
		private static const _Map:Class;

		public function JunkyardLevel(
			backgroundLayer:GameEntity,
			objectLayer:GameEntity,
			foregroundLayer:GameEntity,
			parallaxTarget:GameEntity)
		{
			parallaxTarget.addChild(new JunkyardBG());
			super(_Map, backgroundLayer, objectLayer, foregroundLayer);
		}

		protected override function register(entityName:String, rect:Rectangle):void
		{
			if (entityName == "helparrowleft")
				addToEntityVectorAndStage(new HelpArrow(rect.x, rect.y,
					rect.width, rect.height, -1, 1, 0));
			if (entityName == "levelportal")
				addToEntityVectorAndStage(new LevelPortal(rect.x, rect.y,
					rect.width, rect.height));
			if (entityName == "skeletuna")
				addToEntityVectorAndStage(new Skeletuna(this, rect.x, rect.y,
					rect.width));
			if (entityName == "saw")
				addToEntityVectorAndStage(new Saw(rect.x, rect.y, rect.width,
					rect.height));
			if (entityName == "can")
				addToEntityVectorAndStage(new Can(rect.x, rect.y, rect.width,
					rect.height));
			if (entityName == "cog")
				addToEntityVectorAndStage(new Cog(rect.x, rect.y, this));
		}
	}
}
