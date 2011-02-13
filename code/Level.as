package code
{
	public class Level extends GameEntity
	{
		protected var _map:Map;

		public function Level(LevelData:Class,
			backgroundLayer:GameEntity,
			objectLayer:GameEntity,
			foregroundLayer:GameEntity)
		{
			var file = new LevelData();
			var str = file.readUTFBytes(file.length);
			var levelXML = new XML(str);
			_map = new Map(levelXML, backgroundLayer, foregroundLayer);
		}

		public function getMap():Map
		{
			return _map;
		}
	}
}
