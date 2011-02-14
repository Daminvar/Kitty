package code.levels
{
	import flash.geom.*;

	import code.*;

	public class TestLevel extends Level
	{
		[Embed(source="../../res/testmap.tmx",
			mimeType="application/octet-stream")]
		private static const _Map:Class;

		public function TestLevel(
			backgroundLayer:GameEntity,
			objectLayer:GameEntity,
			foregroundLayer:GameEntity)
		{
			super(_Map, backgroundLayer, objectLayer, foregroundLayer);
		}

		protected override function register(entityName:String, rect:Rectangle):void
		{
			if (entityName == "skeletuna")
				addToEntityVectorAndStage(new Skeletuna(rect.x, rect.y, rect.width));
		}
	}
}
