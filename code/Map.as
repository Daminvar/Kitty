﻿package code
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.utils.*;

	public class Map extends GameEntity
	{
		//The tilemap could be level specific if time permits.
		[Embed(source="../res/tilemap.png")]
		private static var _Tileset:Class;
		private static var _tileset:Bitmap;

		private var _bgTarget:GameEntity;
		private var _collisionEntities:Vector.<GameEntity>;
		private var _dynamicEntities:Vector.<Array>;
		private var _fgTarget:GameEntity;
		private var _isLoaded:Boolean;
		private var _mapHeight:int;
		private var _mapWidth:int;
		private var _renderedMap:Bitmap;
		private var _tileSize:int;
		private var _tiles:Vector.<Vector.<Vector.<int>>>;

		public function get isLoaded():Boolean
		{
			return _isLoaded;
		}

		public function get dynamicEntities():Vector.<Array>
		{
			return _dynamicEntities;
		}

		/** Loads the map specified by the given string. */
		public function Map(loadedMap:XML, bgTarget:GameEntity, fgTarget:GameEntity)
		{
			//Load the tileset if it hasn't been loaded.
			if (_tileset == null)
				_tileset = new _Tileset();
			_bgTarget = bgTarget;
			_fgTarget = fgTarget;
			parseMap(loadedMap);
			renderMap();
		}

		private function parseMap(xmlMap:XML):void
		{
			_mapWidth = xmlMap.@width;
			_mapHeight = xmlMap.@height;
			_tileSize = xmlMap.tileset.@tilewidth; //Assuming square tiles.
			_tiles = new Vector.<Vector.<Vector.<int>>>(xmlMap.layer.data.length());
			//Using a foreach loop gives strange results, so the more verbose
			//for loop version is used.
			for (var i = 0; i < xmlMap.layer.data.length(); i++)
			{
				_tiles[i] = stringTo2DVector(xmlMap.layer.data[i]);
			}
			var collisionObjects:XMLList = xmlMap.objectgroup.(@name == "collision")[0].object;
			_collisionEntities = new Vector.<GameEntity>(collisionObjects.length());
			for (var j = 0; j < collisionObjects.length(); j++)
			{
				var obj = collisionObjects[j];
				_collisionEntities[j] = createFilledEntity(obj.@x, obj.@y,
					obj.@width, obj.@height)
				_fgTarget.addChild(_collisionEntities[j]);
				_collisionEntities[j].showOutline();
			}
			var dynamicObjects:XMLList = xmlMap.objectgroup.(@name == "entities")[0].object;
			_dynamicEntities = new Vector.<Array>();
			for (var k = 0; k < dynamicObjects.length(); k++)
			{
				var dynObj = dynamicObjects[k];
				var keyName:String = dynObj.@name;
				var arr = new Array(keyName, new Rectangle(dynObj.@x,
					dynObj.@y, dynObj.@width, dynObj.@height));
				_dynamicEntities.push(arr);
			}
		}

		private function stringTo2DVector(s:String):Vector.<Vector.<int>>
		{
			var flatLayer = s.split(",").map(function(stringNum:String, index:int, arr:Array) {
				return int(stringNum);
			});
			var layer2D:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(_mapHeight);
			for (var i = 0; i < _mapHeight; i++)
			{
				layer2D[i] = Vector.<int>(flatLayer.slice(i * _mapWidth, (i + 1) * _mapWidth));
			}
			return layer2D;
		}

		private function renderMap():void
		{
			var renderedData = new BitmapData(_tileSize * _mapWidth,
				_tileSize * _mapHeight)

			for (var zIndex = 0; zIndex < _tiles.length; zIndex++)
			{
				var layer = _tiles[zIndex];
				for (var yIndex = 0; yIndex < _mapHeight; yIndex++)
				{
					for (var xIndex = 0; xIndex < _mapWidth; xIndex++)
					{
						//Tiled uses 0 for blank tiles, but that doesn't work
						//so nicely in calculations.
						var tid:int = layer[yIndex][xIndex] - 1;
						if (tid == -1)
							continue;
						var rect:Rectangle = new Rectangle(
							tid * _tileSize % _tileset.width,
							Math.floor((tid * _tileSize) / _tileset.width) * _tileSize,
							_tileSize,
							_tileSize);
						var dest:Point = new Point(
							xIndex * _tileSize,
							yIndex * _tileSize);
						renderedData.copyPixels(_tileset.bitmapData, rect, dest);
					}
				}
			}
			_renderedMap = new Bitmap(renderedData);
			_bgTarget.addChild(_renderedMap);
		}

		private function createFilledEntity(x, y, width, height):GameEntity
		{
			var e = new GameEntity();
			e.x = x;
			e.y = y;
			//This is needed because empty movie clips cannot have widths or
			//heights.
			e.graphics.beginFill(0, 0);
			e.graphics.drawRect(0, 0, width, height);
			e.graphics.endFill();
			return e;
		}

		public function isCollidingWithEnvironment(e:GameEntity):Boolean
		{
			return !_collisionEntities.every(function(r:GameEntity, i:int, v:Vector.<GameEntity>) {
				return !e.isColliding(r);
			});
		}
		
		public function getPixelWidth():Number
		{
			return _mapWidth * _tileSize;
		}
	}
}
