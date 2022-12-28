/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.core;

import feathers.text.FontStylesSet;
import openfl.geom.Point;

/**
 * Interface that handles common capabilities of rendering text.
 *
 * @see ../../../help/text-renderers.html Introduction to Feathers text renderers
 *
 * @productversion Feathers 1.0.0
 */
interface ITextRenderer extends IStateObserver extends IFeathersControl extends ITextBaselineControl {
	/**
	 * The text to render.
	 *
	 * <p>If using the <code>Label</code> component, this property should
	 * be set on the <code>Label</code>, and it will be passed down to the
	 * text renderer.</p>
	 */
	var text(get, set):String;

	// function get_text():String;
	/**
	 * @private
	 */
	// function set_text(value:String):Void;

	/**
	 * Determines if the text wraps to the next line when it reaches the
	 * width (or max width) of the component.
	 *
	 * <p>If using the <code>Label</code> component, this property should
	 * be set on the <code>Label</code>, and it will be passed down to the
	 * text renderer automatically.</p>
	 */
	var wordWrap(get, set):Bool;

	// function get_wordWrap():Bool;
	/**
	 * @private
	 */
	// function set_wordWrap(value:Bool):Void;

	/**
	 * The number of text lines in the text renderer. The text renderer may
	 * contain multiple text lines if the text contains line breaks or if
	 * the <code>wordWrap</code> property is enabled.
	 */
	var numLines(get, never):Int;

	function get_numLines():Int;

	/**
	 * The internal font styles used to render the text that are passed down
	 * from the parent component. Generally, most developers will set font
	 * styles on the parent component.
	 * 
	 * <p>Warning: The <code>fontStyles</code> property may be ignored if
	 * more advanced styles defined by the text renderer implementation have
	 * been set.</p>
	 *
	 * @see http://doc.starling-framework.org/current/starling/text/TextFormat.html starling.text.TextFormat
	 */
	/**
	 * @private
	 */
	var fontStyles(get, set):FontStylesSet;

	/**
	 * Measures the text's bounds (without a full validation, if
	 * possible).
	 */
	function measureText(result:Point = null):Point;
}
