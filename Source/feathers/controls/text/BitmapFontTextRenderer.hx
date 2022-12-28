/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.controls.text;

import starling.text.TextFormat;
import feathers.text.BitmapFontTextFormat;
import starling.display.MeshBatch;
import feathers.skins.IStyleProvider;
import starling.text.BitmapChar;
import feathers.core.ITextRenderer;

/**
 * Renders text using
 * <a href="http://wiki.starling-framework.org/manual/displaying_text#bitmap_fonts" target="_top">bitmap fonts</a>.
 *
 * <p>The following example shows how to use
 * <code>BitmapFontTextRenderer</code> with a <code>Label</code>:</p>
 *
 * <listing version="3.0">
 * var label:Label = new Label();
 * label.text = "I am the very model of a modern Major General";
 * label.textRendererFactory = function():ITextRenderer
 * {
 *     return new BitmapFontTextRenderer();
 * };
 * this.addChild( label );</listing>
 *
 * @see ../../../../help/text-renderers.html Introduction to Feathers text renderers
 * @see ../../../../help/bitmap-font-text-renderer.html How to use the Feathers BitmapFontTextRenderer component
 * @see http://wiki.starling-framework.org/manual/displaying_text#bitmap_fonts Starling Wiki: Displaying Text with Bitmap Fonts
 *
 * @productversion Feathers 1.0.0
 */
class BitmapFontTextRenderer extends BaseTextRenderer implements ITextRenderer {
	/**
	 * @private
	 */
	private static var HELPER_RESULT:MeasureTextResult = new MeasureTextResult();

	/**
	 * @private
	 */
	inline private static var CHARACTER_ID_SPACE:Int = 32;

	/**
	 * @private
	 */
	inline private static var CHARACTER_ID_TAB:Int = 9;

	/**
	 * @private
	 */
	inline private static var CHARACTER_ID_LINE_FEED:Int = 10;

	/**
	 * @private
	 */
	inline private static var CHARACTER_ID_CARRIAGE_RETURN:Int = 13;

	/**
	 * @private
	 */
	private static var CHARACTER_BUFFER:Array<CharLocation>;

	/**
	 * @private
	 */
	private static var CHAR_LOCATION_POOL:Array<CharLocation>;

	/**
	 * @private
	 */
	inline private static var FUZZY_MAX_WIDTH_PADDING:Float = 0.000001;

	/**
	 * The default <code>IStyleProvider</code> for all <code>BitmapFontTextRenderer</code>
	 * components.
	 *
	 * @default null
	 * @see feathers.core.FeathersControl#styleProvider
	 */
	public static var globalStyleProvider:IStyleProvider;

	/**
	 * Constructor.
	 */
	public function new() {
		super();
		if (CHAR_LOCATION_POOL == null) {
			// compiler doesn't like referencing CharLocation class in a
			// static constant
			CHAR_LOCATION_POOL = new Array();
		}
		if (CHARACTER_BUFFER == null) {
			CHARACTER_BUFFER = new Array();
		}
		this.isQuickHitAreaEnabled = true;
	}

	/**
	 * @private
	 */
	private var _characterBatch:MeshBatch = null;

	/**
	 * @private
	 * This variable may be used by subclasses to affect the x position of
	 * the text.
	 */
	private var _batchX:Float = 0;

	/**
	 * @private
	 */
	private var _textFormatChanged:Bool = true;

	/**
	 * @private
	 */
	private var _currentFontStyles:TextFormat = null;

	/**
	 * @private
	 */
	private var _fontStylesTextFormat:BitmapFontTextFormat;

	/**
	 * @private
	 */
	private var _currentVerticalAlign:String;

	/**
	 * @private
	 */
	private var _verticalAlignOffsetY:Float = 0;

	/**
	 * @private
	 */
	private var _currentTextFormat:BitmapFontTextFormat;

	/**
	 * For debugging purposes, the current
	 * <code>feathers.text.BitmapFontTextFormat</code> used to render the
	 * text. Updated during validation, and may be <code>null</code> before
	 * the first validation.
	 * 
	 * <p>Do not modify this value. It is meant for testing and debugging
	 * only. Use the parent's <code>starling.text.TextFormat</code> font
	 * styles APIs instead.</p>
	 */
	public var currentTextFormat(get, never):BitmapFontTextFormat;

	public function get_currentTextFormat():BitmapFontTextFormat {
		return this._currentTextFormat;
	}

	/**
	 * @private
	 */
	override private function get_defaultStyleProvider():IStyleProvider {
		return BitmapFontTextRenderer.globalStyleProvider;
	}

	/**
	 * @private
	 */
	override public function set_maxWidth(value:Float):Float {
		// this is a special case because truncation may bypass normal rules
		// for determining if changing maxWidth should invalidate
		var needsInvalidate:Bool = value > this._explicitMaxWidth && this._lastLayoutIsTruncated;
		super.maxWidth = value;
		if (needsInvalidate) {
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}

		return value;
	}

	/**
		 * @private
		 */
		 private var _numLines:Int = 0;

		 /**
		  * @copy feathers.core.ITextRenderer#numLines
		  */
		public var numLines(get,never):Int;
		 public function get_numLines():Int
		 {
			 return this._numLines;
		 }

		 /**
		 * @private
		 */
		 private var _textFormatForState:Dynamic;

		/**
		 * @private
		 */
		 private var _textFormat:BitmapFontTextFormat;

		 /**
		 * @private
		 */
		 private var _textFormat:BitmapFontTextFormat;
		 /**
		 * Advanced font formatting used to draw the text, if
		 * <code>fontStyles</code> and <code>starling.text.TextFormat</code>
		 * cannot be used on the parent component because the other features of
		 * bitmap fonts are required.
		 *
		 * <p>In the following example, the text format is changed:</p>
		 *
		 * <listing version="3.0">
		 * textRenderer.textFormat = new BitmapFontTextFormat( bitmapFont );</listing>
		 *
		 * <p><strong>Warning:</strong> If this property is not
		 * <code>null</code>, any <code>starling.text.TextFormat</code> font
		 * styles that are passed in from the parent component may be ignored.
		 * In other words, advanced font styling with
		 * <code>BitmapFontTextFormat</code> will always take precedence.</p>
		 *
		 * @default null
		 *
		 * @see #setTextFormatForState()
		 * @see #disabledTextFormat
		 * @see #selectedTextFormat
		 */
		 public var textFormat(get,set):BitmapFontTextFormat;
		public function get_textFormat():BitmapFontTextFormat
			{
				return this._textFormat;
			}
		/**
		 * @private
		 */
		public function set_textFormat(value:BitmapFontTextFormat):BitmapFontTextFormat
		{
			if(this._textFormat == value)
			{
				return this._textFormat;
			}
			this._textFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
			return this._textFormat;
		}

		/**
		 * @private
		 */
		private var _disabledTextFormat:BitmapFontTextFormat;

		/**
		 * Advanced font formatting used to draw the text when the component is
		 * disabled, if <code>disabledFontStyles</code> and
		 * <code>starling.text.TextFormat</code> cannot be used on the parent
		 * component because the other features of bitmap fonts are required.
		 *
		 * <p>In the following example, the disabled text format is changed:</p>
		 *
		 * <listing version="3.0">
		 * textRenderer.isEnabled = false;
		 * textRenderer.disabledTextFormat = new BitmapFontTextFormat( bitmapFont );</listing>
		 *
		 * <p><strong>Warning:</strong> If this property is not
		 * <code>null</code>, any <code>starling.text.TextFormat</code> font
		 * styles that are passed in from the parent component may be ignored.
		 * In other words, advanced font styling with
		 * <code>BitmapFontTextFormat</code> will always take precedence.</p>
		 *
		 * @default null
		 * 
		 * @see #textFormat
		 * @see #selectedTextFormat
		 */
		 public var disabledTextFormat(get,set):BitmapFontTextFormat;
		public function get_disabledTextFormat():BitmapFontTextFormat
		{
			return this._disabledTextFormat;
		}

		/**
		 * @private
		 */
		public function set_disabledTextFormat(value:BitmapFontTextFormat):BitmapFontTextFormat
		{
			if(this._disabledTextFormat == value)
			{
				return this._disabledTextFormat;
			}
			this._disabledTextFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
			return this._disabledTextFormat;
		}

		/**
		 * @private
		 */
		private var _selectedTextFormat:BitmapFontTextFormat;

		/**
		 * Advanced font formatting used to draw the text when the
		 * <code>stateContext</code> is disabled, if
		 * <code>selectedFontStyles</code> and
		 * <code>starling.text.TextFormat</code> cannot be used on the parent
		 * component because the other features of bitmap fonts are required.
		 *
		 * <p>In the following example, the selected text format is changed:</p>
		 *
		 * <listing version="3.0">
		 * textRenderer.selectedTextFormat = new BitmapFontTextFormat( bitmapFont );</listing>
		 *
		 * <p><strong>Warning:</strong> If this property is not
		 * <code>null</code>, any <code>starling.text.TextFormat</code> font
		 * styles that are passed in from the parent component may be ignored.
		 * In other words, advanced font styling with
		 * <code>BitmapFontTextFormat</code> will always take precedence.</p>
		 *
		 * @default null
		 *
		 * @see #stateContext
		 * @see feathers.core.IToggle
		 * @see #textFormat
		 * @see #disabledTextFormat
		 */
		 public var selectedTextFormat(get,set):BitmapFontTextFormat;
		public function get_selectedTextFormat():BitmapFontTextFormat
		{
			return this._selectedTextFormat;
		}

		/**
		 * @private
		 */
		public function set_selectedTextFormat(value:BitmapFontTextFormat):BitmapFontTextFormat
		{
			if(this._selectedTextFormat == value)
			{
				return this._selectedTextFormat;
			}
			this._selectedTextFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
			return this._selectedTextFormat;
		}

		/**
		 * @private
		 */
		private var _textureSmoothing:String = null;

		//[Inspectable(type="String",enumeration="bilinear,trilinear,none")]
		/**
		 * A texture smoothing value passed to each character image. If
		 * <code>null</code>, defaults to the value specified by the
		 * <code>smoothing</code> property of the <code>BitmapFont</code>.
		 * 
		 * <p>In the following example, the texture smoothing is changed:</p>
		 *
		 * <listing version="3.0">
		 * textRenderer.textureSmoothing = TextureSmoothing.NONE;</listing>
		 *
		 * @default null
		 *
		 * @see http://doc.starling-framework.org/core/starling/textures/TextureSmoothing.html starling.textures.TextureSmoothing
		 */
		  public var textureSmoothing(get,set):String;
		public function get_textureSmoothing():String
		{
			return this._textureSmoothing;
		}
		
		/**
		 * @private
		 */
		public function set_textureSmoothing(value:String):String
		{
			if(this._textureSmoothing == value)
			{
				return this._textureSmoothing;
			}
			this._textureSmoothing = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
			return this._textureSmoothing;
		}
}

class CharLocation {
	public function new() {}

	public var char:BitmapChar;
	public var scale:Float;
	public var x:Float;
	public var y:Float;
}
