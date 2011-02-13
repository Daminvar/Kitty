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

	public class Logic extends GameEntity
	{
		var _key:KeyPoll;
		var _kitty:Kitty;
		var _map:Map;
		var _radius:Number;
		var _reticle:Reticle
		var _skeletunaTest:Skeletuna;
		var _background:Background;

		public function Logic()
		{
			_kitty = new Kitty(100,300,this);
			_key = new KeyPoll(this.stage);
			_reticle = new Reticle();
			_radius = 300;
			_skeletunaTest = new Skeletuna(350,180,2,70,30);
			_background = new Background();
			_map = new Map("res/testmap.tmx",
				_background.getBackground(),
				_background.getForeground());
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_background.getBackground());
			addChild(_background.getObjectLayer());
			addChild(_kitty);
			addChild(_reticle);
			addChild(_background.getForeground()); 
			
			_background.addToBackground(_map);
			_background.addToObjectLayer(_skeletunaTest);
		}
		
		public function getMap():Map{
			return _map;
		}
		public function update(e:Event)
		{
			//There should be a better and more generic way of handling this
			//sort of thing.
			if (!_map.isLoaded)
				return;
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
			_skeletunaTest.pace();
			// hairball collision detection
			for (var i:int = 0; i < _kitty.bulletManager.ActiveBullets.length; i++)
			{
				var b:Hairball = _kitty.bulletManager.ActiveBullets[i] as Hairball;
				if (b.hitTestObject(_skeletunaTest))
				{
					//if (b.hitTestPoint(_skeletunaTest.x, _skeletunaTest.y, true))
					//{
						if (contains(_skeletunaTest))
						{
							_background.getObjectLayer().removeChild(_skeletunaTest);
							_kitty.bulletManager.killBullet(b, i);
						}
					//}
				}
			}
		}

		private function handleInput()
		{
			if (_key.isDown(Keyboard.A))
			{
				// BACKGROUND - Uncomment to remove scrolling
				//_kitty.moveLeft();
				// BACKGROUND - Uncomment to remove scrolling
				
				// BACKGROUND - Comment out to remove scrolling
				_background.update("left", _kitty.SPEED);
				// BACKGROUND - Comment out to remove scrolling
				
				_kitty.gotoAndStop("reg_kitty");
			}

			if (_key.isDown(Keyboard.D))
			{
				// BACKGROUND - Uncomment to remove scrolling
				//_kitty.moveRight();
				// BACKGROUND - Uncomment to remove scrolling
				
				// BACKGROUND - Comment out to remove scrolling
				_background.update("right", _kitty.SPEED);
				// BACKGROUND - Comment out to remove scrolling
				
				_kitty.gotoAndStop("reg_kitty");
			}

			if (_key.isDown(Keyboard.SPACE))
			{
				_kitty.jump();
			}

			if (_key.isDown(Keyboard.S))
			{
				_kitty.gotoAndStop("crouch_Kitty");
			}
			else
			{
				_kitty.gotoAndStop("reg_kitty");
			}
		}

		private function onClick(e:MouseEvent):void
		{
			_kitty.fire();
		}
		
	}
}
