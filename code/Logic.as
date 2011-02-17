package code
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

	public class Logic extends GameEntity
	{
		var _background:Background;
		var _key:KeyPoll;
		var _kitty:Kitty;
		var _kittyLayer:GameEntity;
		var _radius:Number;
		var _reticle:Reticle;
		var _testLevel:Level;

		public function Logic()
		{
			_kitty = new Kitty(100,300,this);
			_kittyLayer = new GameEntity();
			_key = new KeyPoll(this.stage);
			_reticle = new Reticle();
			_radius = 300;
			_background = new Background(this);
			_testLevel = new NatureLevel(
				_background.getBackground(),
				_background.getObjectLayer(),
				_background.getForeground(), this);
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_background.getBackground());
			addChild(_background.getObjectLayer());
			addChild(_kittyLayer);
			_kittyLayer.addChild(_kitty);
			addChild(_reticle);
			addChild(_background.getForeground()); 
		}
		
		public function getLevel():Level
		{
			return _testLevel;
		}

		public function update(e:Event)
		{
			if(_kitty.isDead())
			{
				_background.reset();
				_testLevel.reset();
				_kittyLayer.removeChild(_kitty);
				_kitty = new Kitty(100,300,this);
				_kittyLayer.addChild(_kitty);
			}
			handleInput();
			_testLevel.update();
			_kitty.update();
			updateReticle();
			// hairball collision detection
			for (var i:int = 0; i < _kitty.bulletManager.ActiveBullets.length; i++)
			{
				var b:Hairball = _kitty.bulletManager.ActiveBullets[i] as Hairball;
				_testLevel.entities.forEach(function(e:DynamicNPE, i:int, vec:*) {
					e.handleHairball(b);
				});
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
			if (_key.isDown(Keyboard.CONTROL))
				_kitty.fireSpecial();
			else
				_kitty.fireHairball();
		}
		
	}
}
