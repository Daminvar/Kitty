package code
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	/**
	 * The base for all programmed objects that appear on stage.
	 */
	public class GameEntity extends MovieClip
	{
		private var handlers:Dictionary;

		public function GameEntity()
		{
			handlers = new Dictionary();
			addEvent(Event.REMOVED_FROM_STAGE, function(e:Event) {
				removeListeners();
			});
		}

		/** A helper to remove the need for a separate init function. */
		public function onAdded(f:Function):void
		{
			addEvent(Event.ADDED_TO_STAGE, function(e:Event) {
				f.call();
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
			});
		}

		/** A helper function to make cleanup simpler. */
		public function onRemoved(f:Function):void
		{
			addEvent(Event.REMOVED_FROM_STAGE, function(e:Event) {
				f.call();
			});
		}

		/**
		 * Adds an event listener that gets cleaned up when the entity
		 * is removed.
		 */
		protected function addEvent(evt:String, f:Function):void
		{
			handlers[f] = evt;
			addEventListener(evt, f);
		}

		private function removeListeners():void
		{
			for (var key:Object in handlers)
			{
				//This is required because Flash is stupid and tries
				//coerce dictionary keys to Strings when in a for loop.
				var funcKey:Function = key as Function;
				removeEventListener(handlers[funcKey], funcKey);
			}
		}

		/** Returns true if entity is touching the passed-in entity. */
		public function isColliding(e:GameEntity):Boolean
		{
			// Hit test object is fine for these purposes as nearly everything
			// in-game is square.
			return this.hitTestObject(e);
		}
	}
}
