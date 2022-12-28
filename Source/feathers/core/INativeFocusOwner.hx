package feathers.core;

import openfl.display.InteractiveObject;

interface INativeFocusOwner extends IFocusDisplayObject {
    /**
	 * A display object on the native stage that is given focus when this
	 * Feathers display object is given focus by a focus manager.
	 * 
	 * <p>This property may return <code>null</code>. When it returns
	 * <code>null</code>, the focus manager should treat this display object
	 * like any other display object that may receive focus but doesn't
	 * implement <code>INativeFocusOwner</code>.</p>
	 */
	var nativeFocus(get, never):InteractiveObject;
	//function get_nativeFocus():InteractiveObject;
}