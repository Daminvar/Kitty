package code
{
	import flash.geom.*;

	import code.*;
	import flash.display.MovieClip;

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
			_objectLayer = objectLayer;
			var file = new LevelData();
			var str = file.readUTFBytes(file.length);
			var levelXML = new XML(str);
			_map = new Map(levelXML, backgroundLayer, foregroundLayer);
			
			initEntities();
		}

		private function initEntities():void
		{
			_entities = new Vector.<DynamicNPE>();
			for (var i = 0; i < _map.dynamicEntities.length; i++)
				register(_map.dynamicEntities[i][0],
					_map.dynamicEntities[i][1]);
		}

		public function getMap():Map
		{
			return _map;
		}
		
		public function isCollidingWithEnvironment(e:GameEntity)
		{
			return _map.isCollidingWithEnvironment(e) || !_entities.every(
				function(d:DynamicNPE, i:int, v:*) {
				return !d.isCollidable ||  !d.isColliding(e);
			});
		}

		public function update(g:Logic):void
		{
			
			_entities.forEach(function(e:DynamicNPE, i:int, v:*) {
				e.update(g);
			});
		}

		public function reset():void
		{
			_entities.forEach(function(e:DynamicNPE, i:int, v:*) {
				_objectLayer.removeChild(e);
			});
			initEntities();
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
			_objectLayer.removeChild(e);
			_entities = _entities.filter(function(v:DynamicNPE, i:int, vec:*) {
				return v != e;
			});
		}
	}
}
