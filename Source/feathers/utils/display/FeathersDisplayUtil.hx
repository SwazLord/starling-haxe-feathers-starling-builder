package feathers.utils.display;

import starling.display.DisplayObject;

class FeathersDisplayUtil
{
    /**
	 * Calculates how many levels deep the target object is on the display list,
	 * starting from the Starling stage. If the target object is the stage, the
	 * depth will be <code>0</code>. A direct child of the stage will have a
	 * depth of <code>1</code>, and it increases with each new level. If the
	 * object does not have a reference to the stage, the depth will always be
	 * <code>-1</code>, even if the object has a parent.
	 *
	 * @productversion Feathers 1.0.0
	 */
	public static function getDisplayObjectDepthFromStage(target:DisplayObject):Int
        {
            if(target.stage != null)
            {
                return -1;
            }
            var count:Int = 0;
            while(target.parent != null)
            {
                target = target.parent;
                count++;
            }
            return count;
        }
}