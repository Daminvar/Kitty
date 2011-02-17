package code
{
	/** Represents a dynamic Non-Player Entity (NPE) on the map. */
	public class DynamicNPE extends GameEntity
	{
               
		public var isCollidable:Boolean;

		public function update():void
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
