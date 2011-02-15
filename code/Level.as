package code
{
	import flash.geom.*;

	import code.*;

	public class Level extends GameEntity
	{
		protected var _map:Map;
		protected var _entities:Vector.<DynamicNPE>;
		protected var _objectLayer:GameEntity;

		public function get entities():Vector.<DynamicNPE>
		{
			return _entities;
		}

		public function Level(LevelData:Class,
			backgroundLayer:GameEntity,
			objectLayer:GameEntity,
			foregroundLayer:GameEntity)
		{
			_entities = new Vector.<DynamicNPE>();
			_objectLayer = objectLayer;
			var file = new LevelData();
			var str = file.readUTFBytes(file.length);
			var levelXML = new XML(str);
			_map = new Map(levelXML, backgroundLayer, foregroundLayer);
			for (var key:String in _map.dynamicEntities)
				register(key, _map.dynamicEntities[key]);
		}

		public function getMap():Map
		{
			return _map;
		}

		public function update():void
		{
			_entities.forEach(function(e:DynamicNPE, i:int, v:*) {
				e.update();
			});
		}

		protected function register(entityName:String, rect:Rectangle):void
		{
			throw new Error("This method must be overridden.");
		}

		protected function addToEntityVectorAndStage(e:GameEntity):void
		{
			_entities.push(e);
			_objectLayer.addChild(e);
		}

		public function removeEntity(e:DynamicNPE):void
		{
			_entities = _entities.filter(function(v:DynamicNPE, i:int, vec:*) {
				return v != e;
			});
		}
	}
}
