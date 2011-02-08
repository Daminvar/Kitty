package code
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
    import flash.ui.Keyboard;
	
    import uk.co.bigroom.input.*;
	
	public class Logic extends MovieClip
    {
		var _kitty:Kitty;
        var _key:KeyPoll;
		
		public function Logic()
		{
			_kitty = new Kitty(100,300);
            _key = new KeyPoll(this.stage);
			stage.addEventListener(Event.ENTER_FRAME, update);
			addChild(_kitty);
		}
		
		public function update(e:Event)
        {
            handleInput();
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
                _kitty.gotoAndStop("crouch_kitty");
            else
                _kitty.gotoAndStop("reg_kitty");
        }
	}
}
