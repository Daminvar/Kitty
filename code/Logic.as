﻿package code
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.net.*;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;

	import uk.co.bigroom.input.*;
	import fl.motion.easing.Back;

	import code.levels.*;
	import code.entities.*;

	public class Logic extends GameEntity
	{
		var _background:Background;
		var _key:KeyPoll;
		var _kitty:Kitty;
		var _kittyLayer:GameEntity;
		var _radius:Number;
		var _reticle:Reticle;
		var _testLevel:Level;
		var _changeLevel:Boolean;

		public function Logic()
		{
			_kittyLayer = new GameEntity();
			_key = new KeyPoll(this.stage);
			_reticle = new Reticle();
			_radius = 300;
			_background = new Background(this);
			_testLevel = new JunkyardLevel(
				_background.getBackground(),
				_background.getObjectLayer(),
				_background.getForeground(), this);
			initKitty();
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_background.getBackground());
			addChild(_background.getObjectLayer());
			addChild(_kittyLayer);
			_kittyLayer.addChild(_kitty);
			addChild(_reticle);
			addChild(_background.getForeground()); 
			_background.reset();
		}
		
		private function removeLevel():void
		{
			removeChild(_background.getBackground());
			removeChild(_background.getObjectLayer());
			
			_kittyLayer.removeChild(_kitty);
			removeChild(_kittyLayer);
			removeChild(_reticle);
			removeChild(_background.getForeground()); 
		}
		
		private function reAddLevel():void
		{
			_background = new Background(this);
			_background.setMapRight(true);
			_testLevel = new NatureLevel(
				_background.getBackground(),
				_background.getObjectLayer(),
				_background.getForeground(), this);
			
			addChild(_background.getBackground());
			addChild(_background.getObjectLayer());
			addChild(_kittyLayer);
			initKitty();
			_kittyLayer.addChild(_kitty);
			addChild(_reticle);
			addChild(_background.getForeground());
			
			_background.reset();
			_testLevel.reset();
			for (var j = 0; j < _kitty.bulletManager.ActiveBullets.length; j++)
			{
				var h:Hairball = _kitty.bulletManager.ActiveBullets[j] as Hairball;
				removeChild(h);
			}
		}
		
		public function changeLevel():void
		{
			_changeLevel = true;
			removeLevel();
			reAddLevel();
			_changeLevel = false;
			
		}

		private function initKitty():void
		{
			_kitty = new Kitty(_testLevel.getMap().kittySpawnPoint.x %
				stage.stageWidth,
				_testLevel.getMap().kittySpawnPoint.y,
				this);
		}
		
		public function getLevel():Level
		{
			return _testLevel;
		}

		public function update(e:Event)
		{
			if(!_changeLevel)
			{
				if(_kitty.isDead())
				{
					_background.reset();
					_testLevel.reset();
					_kittyLayer.removeChild(_kitty);
					for (var j = 0; j < _kitty.bulletManager.ActiveBullets.length; j++)
					{
						var h:Hairball = _kitty.bulletManager.ActiveBullets[j] as Hairball;
						removeChild(h);
					}
					initKitty();
					_kittyLayer.addChild(_kitty);
				}
				handleInput();
				_testLevel.update(this);
				_kitty.update();
				updateReticle();
				// hairball collision detection
				for (var i:int = 0; i < _kitty.bulletManager.ActiveBullets.length; i++)
				{
					var b:Hairball = _kitty.bulletManager.ActiveBullets[i] as Hairball;
					_testLevel.entities.forEach(function(e:DynamicNPE, i:int, vec:*) {
						e.handleHairball(b);
					});
					
					if(getLevel().isCollidingWithEnvironment(b)){
						_kitty.bulletManager.killBullet(b,i);
					}
				}
			}
		}

		private function updateReticle():void
		{
			var mousePnt = localToGlobal(new Point(mouseX,mouseY));
			var dx:Number = mousePnt.x - _kitty.x;
			var dy:Number = mousePnt.y - _kitty.y;
			var angle:Number = Math.atan2(dy,dx);
                        _reticle.x = mousePnt.x;
			_reticle.y = mousePnt.y;
			if (mousePnt.x > (Math.cos(angle)*_radius)+ _kitty.x && mousePnt.y > (Math.sin(angle)*_radius) + _kitty.y
                                && mousePnt.x > _kitty.x &&       mousePnt.y > _kitty.y)
			{
				_reticle.x = (Math.cos(angle)*_radius)+ _kitty.x;
				_reticle.y = (Math.sin(angle)*_radius) + _kitty.y;
			}
			
			if (mousePnt.x < (Math.cos(angle)*_radius)+ _kitty.x && mousePnt.y > (Math.sin(angle)*_radius) + _kitty.y 
                                    && mousePnt.x < _kitty.x && mousePnt.y > _kitty.y)
			{
				_reticle.x = (Math.cos(angle)*_radius)+ _kitty.x;
				_reticle.y = (Math.sin(angle)*_radius) + _kitty.y;
			}
			
			if (mousePnt.x > (Math.cos(angle)*_radius)+ _kitty.x && mousePnt.y < (Math.sin(angle)*_radius) + _kitty.y 
                                    && mousePnt.x > _kitty.x && mousePnt.y < _kitty.y)
			{
				_reticle.x = (Math.cos(angle)*_radius)+ _kitty.x;
				_reticle.y = (Math.sin(angle)*_radius) + _kitty.y;
			}
			
			if (mousePnt.x < (Math.cos(angle)*_radius)+ _kitty.x && mousePnt.y < (Math.sin(angle)*_radius) + _kitty.y 
                               && mousePnt.x < _kitty.x && mousePnt.y < _kitty.y)
			{
				_reticle.x = (Math.cos(angle)*_radius)+ _kitty.x;
				_reticle.y = (Math.sin(angle)*_radius) + _kitty.y;
			}
		}

		private function handleInput()
		{
			if (_key.isDown(Keyboard.A))
				if(_kitty.canLeft()){
					_kitty.moveLeft();
				} else{
					_background.update("left", _kitty.SPEED);
				}

			if (_key.isDown(Keyboard.D))
				if(_kitty.canRight()){
					_kitty.moveRight();
				}else {
					_background.update("right", _kitty.SPEED);
				}
			if (_key.isDown(Keyboard.SPACE))
				_kitty.jump();
		}

		private function onClick(e:MouseEvent):void
		{
			if (_key.isDown(Keyboard.SHIFT))
				_kitty.fireSpecial();
			else
				_kitty.fireHairball();
		}
		
	}
}
