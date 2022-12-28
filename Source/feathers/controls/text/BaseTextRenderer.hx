/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.controls.text;

import starling.events.Event;
import feathers.text.FontStylesSet;
import feathers.events.FeathersEventType;
import feathers.core.IStateContext;
import feathers.core.IStateObserver;
import feathers.core.FeathersControl;

/**
 * A base class for text renderers that implements some common properties.
 *
 * @productversion Feathers 3.1.0
 */
class BaseTextRenderer extends FeathersControl implements IStateObserver {
	public function new() {
		super();
	}

	/**
	 * @private
	 */
	private var _text:String = null;

	/**
	 * @copy feathers.core.ITextRenderer#text
	 */
	public var text(get, set):String;

	public function get_text():String {
		return this._text;
	}

	/**
	 * @private
	 */
	public function set_text(value:String):String {
		if (this._text == value) {
			return this._text;
		}
		this._text = value;
		this.invalidate(INVALIDATION_FLAG_DATA);
		return this._text;
	}

	/**
	 * @private
	 */
	private var _stateContext:IStateContext;

	/**
	 * When the text renderer observes a state context, the text renderer
	 * may change its font styles based on the current state of that
	 * context. Typically, a relevant component will automatically assign
	 * itself as the state context of a text renderer, so this property is
	 * typically meant for internal use only.
	 *
	 * @default null
	 *
	 * @see #setFontStylesForState()
	 */
	public var stateContext(get, set):IStateContext;

	public function get_stateContext():IStateContext {
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
	private var _wordWrap:Bool = false;

	/**
	 * @copy feathers.core.ITextRenderer#wordWrap
	 */
	public var wordWrap(get, set):Bool;

	public function get_wordWrap():Bool {
		return this._wordWrap;
	}

	/**
	 * @private
	 */
	public function set_wordWrap(value:Bool):Bool {
		if (this._wordWrap == value) {
			return this._wordWrap;
		}
		this._wordWrap = value;
		this.invalidate(INVALIDATION_FLAG_STYLES);
		return this._wordWrap;
	}
    /**
		 * @private
		 */
	private var _fontStyles:FontStylesSet;
    /**
		 * @copy feathers.core.ITextRenderer#fontStyles
		 */
         public var fontStyles(get, set):FontStylesSet;
		public function get_fontStyles():FontStylesSet
            {
                return this._fontStyles;
            }
        /**
		 * @private
		 */
		public function set_fontStyles(value:FontStylesSet):FontStylesSet
            {
                if(this._fontStyles == value)
                {
                    return this._fontStyles;
                }
                if(this._fontStyles != null)
                {
                    this._fontStyles.removeEventListener(Event.CHANGE, fontStylesSet_changeHandler);
                }
                this._fontStyles = value;
                if(this._fontStyles != null)
                {
                    this._fontStyles.addEventListener(Event.CHANGE, fontStylesSet_changeHandler);
                }
                this.invalidate(INVALIDATION_FLAG_STYLES);
                return this._fontStyles;
            }

        /**
		 * @private
		 */
		override public function dispose():Void
            {
                this.stateContext = null;
                this.fontStyles = null;
                super.dispose();
            }
        /**
		 * @private
		 */
		private function stateContext_stateChangeHandler(event:Event):Void
            {
                this.invalidate(INVALIDATION_FLAG_STATE);
            }
        /**
		 * @private
		 */
         private function fontStylesSet_changeHandler(event:Event):Void
            {
                this.invalidate(INVALIDATION_FLAG_STYLES);
            }
}
