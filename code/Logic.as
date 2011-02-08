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

	public class Logic extends MovieClip
	{
		var _kitty:Kitty;
		var _key:KeyPoll;
		var reticle:Reticle;
		var radius:Number;

		public function Logic()
		{
			_kitty = new Kitty(100,300,this);
			_key = new KeyPoll(this.stage);
			reticle = new Reticle();
			radius = 300;
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addChild(_kitty);
			addChild(reticle);
		}

		public function update(e:Event)
		{
			handleInput();
			_kitty.bulletManager.update();
			var mousePnt = localToGlobal(new Point(mouseX,mouseY));
			var dx:Number = mousePnt.x - _kitty.x;
			var dy:Number = mousePnt.y - _kitty.y;
			var angle:Number = Math.atan2(dy,dx);
			if (mousePnt.x > (Math.cos(angle)*radius)+ _kitty.x)
			{
				reticle.x = (Math.cos(angle)*radius)+ _kitty.x;
			}
			if (mousePnt.y > (Math.sin(angle)*radius) + _kitty.y)
			{
				reticle.y = (Math.sin(angle)*radius) + _kitty.y;
			}
			else
			{
				reticle.x = mousePnt.x;
				reticle.y = mousePnt.y;
			}
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