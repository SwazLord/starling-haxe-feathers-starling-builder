/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.core;

import starling.events.Event;
import starling.events.EventDispatcher;

/**
 * Dispatched when a token is added, removed, or toggled or if all tokens
 * have been replaced by setting the <code>value</code> property.
 *
 * <p>The properties of the event object have the following values:</p>
 * <table class="innertable">
 * <tr><th>Property</th><th>Value</th></tr>
 * <tr><td><code>bubbles</code></td><td>false</td></tr>
 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *   event listener that handles the event. For example, if you use
 *   <code>myButton.addEventListener()</code> to register an event listener,
 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
 * <tr><td><code>data</code></td><td>null</td></tr>
 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *   it is not always the Object listening for the event. Use the
 *   <code>currentTarget</code> property to always access the Object
 *   listening for the event.</td></tr>
 * </table>
 *
 * @eventType starling.events.Event.CHANGE
 */
/**
 * A list of space-delimited tokens. Obviously, since they are delimited by
 * spaces, tokens cannot contain spaces.
 *
 * @productversion Feathers 1.0.0
 */
class TokenList extends EventDispatcher {
	/**
	 * Constructor.
	 */
	public function new() {
		super();
	}

	private var _joinedNames:String = null;

	/**
	 * @private
	 * Storage for the tokens.
	 */
	private var names:Array<String> = new Array();

	/**
	 * The tokens formatted with space delimiters.
	 *
	 * @default ""
	 */
	public var value(get, set):String;

	public function get_value():String {
		if (this._joinedNames == null) {
			this._joinedNames = names.join(" ");
		}
		return this._joinedNames;
	}

	/**
	 * @private
	 */
	public function set_value(value:String):String {
		if (this.value == value) {
			return this.value;
		}
		this._joinedNames = value;
		this.names = [];
		this.names = value.split(" ");
		this.dispatchEventWith(Event.CHANGE);
		return this.value;
	}

	/**
	 * The number of tokens in the list.
	 */
	public var length(get, never):Int;

	public function get_length():Int {
		return this.names.length;
	}

	/**
	 * Returns the token at the specified index, or null, if there is no
	 * token at that index.
	 */
	public function item(index:Int):String {
		if (index < 0 || index >= this.names.length) {
			return null;
		}
		return this.names[index];
	}

	/**
	 * Adds a token to the list. If the token already appears in the list,
	 * it will not be added again.
	 */
	public function add(name:String):Void {
		var index:Int = this.names.indexOf(name);
		if (index >= 0) {
			return;
		}
		if (this._joinedNames != null) {
			this._joinedNames += " " + name;
		}
		this.names[this.names.length] = name;
		this.dispatchEventWith(Event.CHANGE);
	}

	/**
	 * Removes a token from the list, if the token is in the list. If the
	 * token doesn't appear in the list, this call does nothing.
	 */
	public function remove(name:String):Void {
		var index:Int = this.names.indexOf(name);
		this.removeAt(index);
	}

	/**
	 * The token is added to the list if it doesn't appear in the list, or
	 * it is removed from the list if it is already in the list.
	 */
	public function toggle(name:String):Void {
		var index:Int = this.names.indexOf(name);
		if (index < 0) {
			if (this._joinedNames != null) {
				this._joinedNames += " " + name;
			}
			this.names[this.names.length] = name;
			this.dispatchEventWith(Event.CHANGE);
		} else {
			this.removeAt(index);
		}
	}

	/**
	 * Determines if the specified token is in the list.
	 */
	public function contains(name:String):Bool {
		return this.names.indexOf(name) >= 0;
	}

	/**
	 * @private
	 */
	 private function removeAt(index:Int):Void
		{
			if(index < 0)
			{
				return;
			}
			this._joinedNames = null;
			this.names.splice(index,  1);
			this.dispatchEventWith(Event.CHANGE);
		}
}