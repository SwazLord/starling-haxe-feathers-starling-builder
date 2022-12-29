/*
	Feathers
	Copyright 2012-2015 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.core;

import haxe.Constraints.Function;
import starling.events.Event;

interface IFeathersEventDispatcher {
	/**
	 * Adds a listener for an event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#addEventListener() Full description of starling.events.EventDispatcher.addEventListener() in Gamua's Starling Framework API Reference
	 */
	function addEventListener(type:String, listener:Function):Void;

	/**
	 * Removes a listener for an event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#removeEventListener() Full description of starling.events.EventDispatcher.addEventListener() in Gamua's Starling Framework API Reference
	 */
	function removeEventListener(type:String, listener:Function):Void;

	/**
	 * Removes all listeners for an event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#removeEventListeners() Full description of starling.events.EventDispatcher.removeEventListeners() in Gamua's Starling Framework API Reference
	 */
	function removeEventListeners(type:String = null):Void;

	/**
	 * Dispatches an event to all listeners added for the specified event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#dispatchEvent() Full description of starling.events.EventDispatcher.dispatchEvent() in Gamua's Starling Framework API Reference
	 */
	function dispatchEvent(event:Event):Void;

	/**
	 * Dispatches an event from the pool with the specified to all listeners
	 * for the specified event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#dispatchEventWith() Full description of starling.events.EventDispatcher.dispatchEventWith() in Gamua's Starling Framework API Reference
	 */
	function dispatchEventWith(type:String, bubbles:Bool = false, data:Dynamic = null):Void;

	/**
	 * Checks if a listener has been added for the specified event type.
	 *
	 * @see http://doc.starling-framework.org/core/starling/events/EventDispatcher.html#hasEventListener() Full description of starling.events.EventDispatcher.hasEventListener() in Gamua's Starling Framework API Reference
	 */
	function hasEventListener(type:String):Bool;
}
