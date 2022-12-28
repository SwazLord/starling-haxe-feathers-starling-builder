package feathers.core;
/**
	 * If a display object implements <code>INativeFocusOwner</code> and its
	 * <code>nativeFocus</code> property does not return a
	 * <code>flash.display.InteractiveObject</code> (or <code>null</code>), it
	 * must implement this interface so that the focus manager can tell it when
	 * to give focus to its native focus object.
	 *
	 * @see ../../../help/focus.html
	 *
	 * @productversion Feathers 3.0.0
	 */
interface IAdvancedNativeFocusOwner extends INativeFocusOwner {
    /**
		 * Determines if <code>nativeFocus</code> currently has focus.
		 */
    var hasFocus(get, never):Bool;
    /**
		 * Called by the focus manager to set focus on <code>nativeFocus</code>.
		 * May also be called manually.
		 */
	function setFocus():Void;
}