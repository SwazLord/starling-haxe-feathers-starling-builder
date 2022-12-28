/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.core;

import feathers.text.FontStylesSet;
import feathers.events.FeathersEventType;
import starling.events.Event;

/**
 * A base class for text editors that implements some common properties.
 *
 * @productversion Feathers 3.1.0
 */
class BaseTextEditor extends FeathersControl implements IStateObserver {
	/**
	 * Constructor.
	 */
	public function new() {
		super();
	}

	/**
	 * @private
	 */
	private var _text:String = "";

	/**
	 * @copy feathers.core.ITextEditor#text
	 */
	public var text(get, set):String;

	public function get_text():String {
		return this._text;
	}

	/**
	 * @private
	 */
	public function set_text(value:String):String {
		if (value == null) {
			// don't allow null or undefined
			value = "";
		}
		if (this._text == value) {
			return this._text;
		}
		this._text = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		this.dispatchEventWith(Event.CHANGE);
		return this._text;
	}

	/**
	 * @private
	 */
	private var _stateContext:IStateContext;

	/**
	 * When the text editor observes a state context, the text editor may
	 * change its font styles based on the current state of that context.
	 * Typically, a relevant component will automatically assign itself as
	 * the state context of a text editor, so this property is typically
	 * meant for internal use only.
	 *
	 * @default null
	 *
	 * @see #setFontStylesForState()
	 */
	public var stateContext(get, set):IStateContext;

	private function get_stateContext():IStateContext {
		return this._stateContext;
	}

	/**
	 * @private
	 */
	public function set_stateContext(value:IStateContext):IStateContext {
		if (this._stateContext == value) {
			return this._stateContext;
		}
		if (this._stateContext != null) {
			this._stateContext.removeEventListener(FeathersEventType.STATE_CHANGE, stateContext_stateChangeHandler);
		}
		this._stateContext = value;
		if (this._stateContext != null) {
			this._stateContext.addEventListener(FeathersEventType.STATE_CHANGE, stateContext_stateChangeHandler);
		}
		this.invalidate(INVALIDATION_FLAG_STATE);
		return this._stateContext;
	}

	/**
	 * @private
	 */
	private var _fontStyles:FontStylesSet;

	/**
	 * @copy feathers.core.ITextEditor#fontStyles
	 */
	public var fontStyles(get, set):FontStylesSet;

	public function get_fontStyles():FontStylesSet {
		return this._fontStyles;
	}

	/**
	 * @private
	 */
	public function set_fontStyles(value:FontStylesSet):FontStylesSet {
		if (this._fontStyles == value) {
			return this._fontStyles;
		}
		if (this._fontStyles != null) {
			this._fontStyles.removeEventListener(Event.CHANGE, fontStylesSet_changeHandler);
		}
		this._fontStyles = value;
		if (this._fontStyles != null) {
			this._fontStyles.addEventListener(Event.CHANGE, fontStylesSet_changeHandler);
		}
		this.invalidate(INVALIDATION_FLAG_STYLES);
		return this._fontStyles;
	}

	/**
	 * @private
	 */
	override public function dispose():Void {
		this.stateContext = null;
		this.fontStyles = null;
		super.dispose();
	}

	/**
	 * @private
	 */
	private function stateContext_stateChangeHandler(event:Event):Void {
		this.invalidate(INVALIDATION_FLAG_STATE);
	}

	/**
	 * @private
	 */
	private function fontStylesSet_changeHandler(event:Event):Void {
		this.invalidate(INVALIDATION_FLAG_STYLES);
	}
}
