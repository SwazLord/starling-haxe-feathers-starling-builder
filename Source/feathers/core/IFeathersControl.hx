package feathers.core;

import feathers.skins.IStyleProvider;

interface IFeathersControl extends IValidating extends IMeasureDisplayObject {
	/**
	 * @copy feathers.core.FeathersControl#isEnabled
	 */
	/**
	 * @private
	 */
	var isEnabled(get, set):Bool;

	/**
	 * @copy feathers.core.FeathersControl#isInitialized
	 */
	var isInitialized(get, never):Bool;

	function get_isInitialized():Bool;

	/**
	 * @copy feathers.core.FeathersControl#isCreated
	 */
	var isCreated(get, never):Bool;

	function get_isCreated():Bool;

	/**
	 * @copy feathers.core.FeathersControl#styleNameList
	 */
	var styleNameList(get, never):TokenList;

	function get_styleNameList():TokenList;
	/**
	 * @copy feathers.core.FeathersControl#styleName
	 */
	/**
	 * @private
	 */
	var styleName(get, set):String;

	/**
	 * @copy feathers.core.FeathersControl#styleProvider
	 */
	/**
	 * @private
	 */
	var styleProvider(get, set):IStyleProvider;

	/**
	 * @copy feathers.core.FeathersControl#toolTip
	 */
	/**
	 * @private
	 */
	var toolTip(get, set):String;

	/**
	 * @copy feathers.core.FeathersControl#effectsSuspended
	 */
	var effectsSuspended(get, never):Bool;

	function get_effectsSuspended():Bool;

	/**
	 * @copy feathers.core.FeathersControl#setSize()
	 */
	function setSize(width:Float, height:Float):Void;

	/**
	 * @copy feathers.core.FeathersControl#move()
	 */
	function move(x:Float, y:Float):Void;

	/**
	 * @copy feathers.core.FeathersControl#resetStyleProvider()
	 */
	function resetStyleProvider():Void;

	/**
	 * @copy feathers.core.FeathersControl#initializeNow()
	 */
	function initializeNow():Void;

	/**
	 * @copy feathers.core.FeathersControl#suspendEffects()
	 */
	function suspendEffects():Void;

	/**
	 * @copy feathers.core.FeathersControl#resumeEffects()
	 */
	function resumeEffects():Void;
}
