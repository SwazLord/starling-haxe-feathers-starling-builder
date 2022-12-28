package feathers.core;

import feathers.core.IFocusDisplayObject;
import starling.display.DisplayObjectContainer;

interface IFocusManager {
    var isEnabled(get, set):Bool;
    var focus(get, set):IFocusDisplayObject;
    var root(get, never):DisplayObjectContainer;
	function get_root():DisplayObjectContainer;
}