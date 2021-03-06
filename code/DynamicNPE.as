﻿package code
{
	/** Represents a dynamic Non-Player Entity (NPE) on the map. */
	public class DynamicNPE extends GameEntity
	{
		protected var _isCollidable:Boolean;

		public function get isCollidable():Boolean
		{
			return _isCollidable;
		}

		public function update(g:Logic):void
		{
			throw new Error("This method must be overridden.");
		}

		public function handleHairball(h:Hairball):void
		{
			return;
		}

		public function handleCollision(k:Kitty):void
		{
			return;
		}
	}
}
