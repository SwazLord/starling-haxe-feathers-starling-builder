package feathers.core;

interface IFocusDisplayObject extends IFeathersDisplayObject
{
    var focusManager(get, set):IFocusManager;
    var isFocusEnabled(get, set):Bool;
    var nextTabFocus(get, set):IFocusDisplayObject;
    var previousTabFocus(get, set):IFocusDisplayObject;
    var nextUpFocus(get, set):IFocusDisplayObject;
    var nextRightFocus(get, set):IFocusDisplayObject;
    var nextDownFocus(get, set):IFocusDisplayObject;
    var nextLeftFocus(get, set):IFocusDisplayObject;
    var focusOwner(get, set):IFocusDisplayObject;
    var isShowingFocus(get, never):Bool;
    function get_isShowingFocus():Bool;
    var maintainTouchFocus(get, never):Bool;
    function get_maintainTouchFocus():Bool;
    function showFocus():Void;
    function hideFocus():Void;
}