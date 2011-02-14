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
		var _radius:Number;
		var _reticle:Reticle;
		var _testLevel:Level;

		public function Logic()
		{
			_kitty = new Kitty(100,300,this);
			_key = new KeyPoll(this.stage);
			_reticle = new Reticle();
			_radius = 300;
			_background = new Background(this);
			_testLevel = new TestLevel(
				_background.getBackground(),
				_background.getObjectLayer(),
				_background.getForeground());
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_background.getBackground());
			addChild(_background.getObjectLayer());
			addChild(_kitty);
			addChild(_reticle);
			addChild(_background.getForeground()); 
		}
		
		public function getMap():Map
		{
			return _testLevel.getMap();
		}
		public function update(e:Event)
		{
			if(_kitty.isDead())
			{
				_background.reset();
				removeChild(_kitty);
				_kitty = new Kitty(100,300,this);
				addChild(_kitty);
			}
			handleInput();
			_kitty.bulletManager.update();
			_kitty.fall();
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
			// hairball collision detection
			for (var i:int = 0; i < _kitty.bulletManager.ActiveBullets.length; i++)
			{
				var b:Hairball = _kitty.bulletManager.ActiveBullets[i] as Hairball;
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
			_kitty.fire();
		}
		
	}
}
