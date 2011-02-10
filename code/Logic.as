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

	public class Logic extends GameEntity
	{
		var _key:KeyPoll;
		var _kitty:Kitty;
		var _map:Map;
		var _radius:Number;
		var _reticle:Reticle

		public function Logic()
		{
			_kitty = new Kitty(100,300,this);
			_key = new KeyPoll(this.stage);
			_map = new Map("res/testmap.tmx");
			_reticle = new Reticle();
			_radius = 300;
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_map);
			addChild(_kitty);
			addChild(_reticle);
		}

		public function update(e:Event)
		{
			//There should be a better and more generic way of handling this
			//sort of thing.
			if (!_map.isLoaded)
				return;
			handleInput();
			_kitty.bulletManager.update();
			var mousePnt = localToGlobal(new Point(mouseX,mouseY));
			var dx:Number = mousePnt.x - _kitty.x;
			var dy:Number = mousePnt.y - _kitty.y;
			var angle:Number = Math.atan2(dy,dx);
			if (mousePnt.x > (Math.cos(angle)*_radius)+ _kitty.x)
			{
				_reticle.x = (Math.cos(angle)*_radius)+ _kitty.x;
			}
			if (mousePnt.y > (Math.sin(angle)*_radius) + _kitty.y)
			{
				_reticle.y = (Math.sin(angle)*_radius) + _kitty.y;
			}
			else
			{
				_reticle.x = mousePnt.x;
				_reticle.y = mousePnt.y;
			}
			trace (_map.isCollidingWithEnvironment(_kitty.getRect(this)));
		}

		private function handleInput()
		{
			if (_key.isDown(Keyboard.A))
			{
				_kitty.moveLeft();
				_kitty.gotoAndStop("reg_kitty");
			}

			if (_key.isDown(Keyboard.D))
			{
				_kitty.moveRight();
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
