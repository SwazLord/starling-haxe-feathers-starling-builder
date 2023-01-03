/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.controls.text;

import starling.textures.ConcreteTexture;
import starling.utils.SystemUtil;
import feathers.utils.geom.FeathersGeomUtils;
import openfl.text.TextField;
import feathers.text.StageTextField;
import starling.textures.Texture;
import openfl.errors.Error;
import openfl.display.BitmapData;
import feathers.utils.display.FeathersUIUtils;
import starling.utils.MatrixUtil;
import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;
import starling.display.DisplayObjectContainer;
import feathers.core.IFocusDisplayObject;
import starling.display.DisplayObject;
import openfl.display.Stage;
import feathers.events.FeathersEventType;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import starling.utils.Align;
import starling.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.rendering.Painter;
import openfl.geom.Matrix;
import starling.utils.Pool;
import starling.core.Starling;
import feathers.core.FeathersControl;
import starling.display.Image;
import openfl.display.InteractiveObject;
import feathers.skins.IStyleProvider;
import feathers.core.IMultilineTextEditor;
import feathers.core.INativeFocusOwner;
import feathers.core.BaseTextEditor;
#if flash
import flash.events.SoftKeyboardEvent;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
#end

/**
 * Dispatched when the text property changes.
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
 * @see #text
 *
 * @eventType starling.events.Event.CHANGE
 */
// [Event(name="change",type="starling.events.Event")]
/**
 * Dispatched when the user presses the Enter key while the editor has
 * focus. This event may not be dispatched on some platforms, depending on
 * the value of <code>returnKeyLabel</code>. This issue may even occur when
 * using the <em>default value</em> of <code>returnKeyLabel</code>!
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
 * @see #returnKeyLabel
 *
 * @eventType feathers.events.FeathersEventType.ENTER
 */
// [Event(name="enter",type="starling.events.Event")]
/**
 * Dispatched when the text editor receives focus.
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
 * @eventType feathers.events.FeathersEventType.FOCUS_IN
 */
// [Event(name="focusIn",type="starling.events.Event")]
/**
 * Dispatched when the text editor loses focus.
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
 * @eventType feathers.events.FeathersEventType.FOCUS_OUT
 */
// [Event(name="focusOut",type="starling.events.Event")]
/**
 * Dispatched when the soft keyboard is about to activate. Not all text
 * editors will activate a soft keyboard.
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
 * @eventType feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATING
 */
// [Event(name="softKeyboardActivating",type="starling.events.Event")]
/**
 * Dispatched when the soft keyboard is activated. Not all text editors will
 * activate a soft keyboard.
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
 * @eventType feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATE
 */
// [Event(name="softKeyboardActivate",type="starling.events.Event")]
/**
 * Dispatched when the soft keyboard is deactivated. Not all text editors
 * will activate a soft keyboard.
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
 * @eventType feathers.events.FeathersEventType.SOFT_KEYBOARD_DEACTIVATE
 */
// Event(name="softKeyboardDeactivate",type="starling.events.Event")]

/**
 * Text that may be edited at runtime by the user with the
 * <code>TextInput</code> component, rendered with the native
 * <code>flash.text.StageText</code> class in Adobe AIR and the custom
 * <code>feathers.text.StageTextField</code> class in Adobe Flash Player
 * (<code>StageTextField</code> simulates <code>StageText</code> using
 * <code>flash.text.TextField</code>). When not in focus, the
 * <code>StageText</code> (or <code>StageTextField</code>) is drawn to
 * <code>BitmapData</code> and uploaded to a texture on the GPU. Textures
 * are managed internally by this component, and they will be automatically
 * disposed when the component is disposed.
 *
 * <p>The following example shows how to use
 * <code>StageTextTextEditor</code> with a <code>TextInput</code>:</p>
 *
 * <listing version="3.0">
 * var input:TextInput = new TextInput();
 * input.textEditorFactory = function():ITextEditor
 * {
 *     return new StageTextTextEditor();
 * };
 * this.addChild( input );</listing>
 *
 * @see feathers.controls.TextInput
 * @see ../../../../help/text-editors.html Introduction to Feathers text editors
 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html flash.text.StageText
 * @see feathers.text.StageTextField
 *
 * @productversion Feathers 1.0.0
 */
class StageTextTextEditor extends BaseTextEditor implements IMultilineTextEditor implements INativeFocusOwner {
	/**
	 * The default <code>IStyleProvider</code> for all <code>StageTextTextEditor</code>
	 * components.
	 *
	 * @default null
	 * @see feathers.core.FeathersControl#styleProvider
	 */
	public static var globalStyleProvider:IStyleProvider;

	/**
	 * @private
	 * The minimum position of the StageText view port. A runtime will be
	 * thrown if the x or y position is smaller than this value.
	 */
	inline private static var MIN_VIEW_PORT_POSITION:Float = -8192;

	/**
	 * @private
	 * The maximum position of the StageText view port. A runtime will be
	 * thrown if the x or y position (including width and height) is larger
	 * than this value.
	 */
	inline private static var MAX_VIEW_PORT_POSITION:Float = 8191;

	/**
	 * Constructor.
	 */
	public var isShowingFocus(get, never):Bool;

	public function new() {
		super();
		// TODO: Check OS
		// this._stageTextIsTextField = ~/^(Windows|Mac OS|Linux) .*/.match(Capabilities.os);
		this._stageTextIsTextField = true;
		this.isQuickHitAreaEnabled = true;
		this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, textEditor_removedFromStageHandler);
	}

	/**
	 * @private
	 */
	override public function get_defaultStyleProvider():IStyleProvider {
		return globalStyleProvider;
	}

	/**
	 * The StageText instance. It's typed Object so that a replacement class
	 * can be used in browser-based Flash Player.
	 */
	private var stageText:Dynamic;

	/**
	 * @copy feathers.core.INativeFocusOwner#nativeFocus
	 */
	public var nativeFocus(get, never):InteractiveObject;

	public function get_nativeFocus():InteractiveObject {
		if (!this._isEditable) {
			// assignFocus() doesn't work if StageText's editable property
			// is false, so we'll just let the FocusManager take care of it
			return null;
		}
		return this.stageText;
	}

	/**
	 * An image that displays a snapshot of the native <code>StageText</code>
	 * in the Starling display list when the editor doesn't have focus.
	 */
	private var textSnapshot:Image;

	/**
	 * @private
	 */
	private var _needsNewTexture:Bool = false;

	/**
	 * @private
	 */
	private var _needsTextureUpdate:Bool = false;

	/**
	 * @private
	 */
	private var _ignoreStageTextChanges:Bool = false;

	/**
	 * @private
	 */
	private var _measureTextField:TextField;

	/**
	 * @private
	 * This flag tells us if StageText is implemented by a TextField under
	 * the hood. We want to eliminate that damn TextField gutter to improve
	 * consistency across platforms.
	 */
	private var _stageTextIsTextField:Bool = false;

	/**
	 * @private
	 */
	private var _stageTextHasFocus:Bool = false;

	/**
	 * @private
	 */
	private var _isWaitingToSetFocus:Bool = false;

	/**
	 * @private
	 */
	private var _pendingSelectionBeginIndex:Int = -1;

	/**
	 * @inheritDoc
	 */
	public var selectionBeginIndex(get, never):Int;

	public function get_selectionBeginIndex():Int {
		if (this._pendingSelectionBeginIndex >= 0) {
			return this._pendingSelectionBeginIndex;
		}
		if (this.stageText) {
			return this.stageText.selectionAnchorIndex;
		}
		return 0;
	}

	/**
	 * @private
	 */
	private var _pendingSelectionEndIndex:Int = -1;

	/**
	 * @inheritDoc
	 */
	public var selectionEndIndex(get, never):Int;

	public function get_selectionEndIndex():Int {
		if (this._pendingSelectionEndIndex >= 0) {
			return this._pendingSelectionEndIndex;
		}
		if (this.stageText) {
			return this.stageText.selectionActiveIndex;
		}
		return 0;
	}

	/**
	 * @private
	 */
	private var _stageTextIsComplete:Bool = false;

	/**
	 * @inheritDoc
	 */
	public var baseline(get, never):Float;

	public function get_baseline():Float {
		if (this._measureTextField == null) {
			return 0;
		}
		return this._measureTextField.getLineMetrics(0).ascent;
	}

	/**
	 * @private
	 */
	private var _autoCapitalize:String = "none";

	/**
	 * Controls how a device applies auto capitalization to user input. This
	 * property is only a hint to the underlying platform, because not all
	 * devices and operating systems support this functionality.
	 *
	 * <p>In the following example, the auto capitalize behavior is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.autoCapitalize = AutoCapitalize.WORD;</listing>
	 *
	 * @default flash.text.AutoCapitalize.NONE
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#autoCapitalize Full description of flash.text.StageText.autoCapitalize in Adobe's Flash Platform API Reference
	 */
	public var autoCapitalize(get, set):String;

	public function get_autoCapitalize():String {
		return this._autoCapitalize;
	}

	/**
	 * @private
	 */
	public function set_autoCapitalize(value:String):String {
		if (this._autoCapitalize == value) {
			return this._autoCapitalize;
		}
		this._autoCapitalize = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._autoCapitalize;
	}

	/**
	 * @private
	 */
	private var _autoCorrect:Bool = false;

	/**
	 * Indicates whether a device auto-corrects user input for spelling or
	 * punctuation mistakes. This property is only a hint to the underlying
	 * platform, because not all devices and operating systems support this
	 * functionality.
	 *
	 * <p>In the following example, auto correct is enabled:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.autoCorrect = true;</listing>
	 *
	 * @default false
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#autoCorrect Full description of openfl.text.StageText.autoCorrect in Adobe's Flash Platform API Reference
	 */
	public var autoCorrect(get, set):Bool;

	public function get_autoCorrect():Bool {
		return this._autoCorrect;
	}

	/**
	 * @private
	 */
	public function set_autoCorrect(value:Bool):Bool {
		if (this._autoCorrect == value) {
			return this._autoCorrect;
		}
		this._autoCorrect = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._autoCorrect;
	}

	/**
	 * @private
	 */
	private var _color:UInt = 0xFFFFFFFF;

	/**
	 * Specifies text color as a number containing three 8-bit RGB
	 * components.
	 *
	 * <p>In the following example, the text color is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.color = 0xff9900;</listing>
	 *
	 * @default 0x000000
	 *
	 * @see #disabledColor
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#color Full description of openfl.text.StageText.color in Adobe's Flash Platform API Reference
	 */
	public var color(get, set):UInt;

	public function get_color():UInt {
		return this._color;
	}

	/**
	 * @private
	 */
	public function set_color(value:UInt):UInt {
		if (this._color == value) {
			return this._color;
		}
		this._color = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._color;
	}

	/**
	 * @private
	 */
	private var _disabledColor:UInt = 0x999999;

	/**
	 * Specifies text color when the component is disabled as a number
	 * containing three 8-bit RGB components.
	 *
	 * <p>In the following example, the text color is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.isEnabled = false;
	 * textEditor.disabledColor = 0xff9900;</listing>
	 *
	 * @default 0x999999
	 *
	 * @see #disabledColor
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#color Full description of openfl.text.StageText.color in Adobe's Flash Platform API Reference
	 */
	public var disabledColor(get, set):UInt;

	public function get_disabledColor():UInt {
		return this._disabledColor;
	}

	/**
	 * @private
	 */
	public function set_disabledColor(value:UInt):UInt {
		if (this._disabledColor == value) {
			return this._disabledColor;
		}
		this._disabledColor = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._disabledColor;
	}

	/**
	 * @private
	 */
	private var _displayAsPassword:Bool = false;

	/**
	 * Indicates whether the text field is a password text field that hides
	 * input characters using a substitute character.
	 *
	 * <p>In the following example, the text is displayed as a password:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.displayAsPassword = true;</listing>
	 *
	 * @default false
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#displayAsPassword Full description of openfl.text.StageText.displayAsPassword in Adobe's Flash Platform API Reference
	 */
	public var displayAsPassword(get, set):Bool;

	public function get_displayAsPassword():Bool {
		return this._displayAsPassword;
	}

	/**
	 * @private
	 */
	public function set_displayAsPassword(value:Bool):Bool {
		if (this._displayAsPassword == value) {
			return this._displayAsPassword;
		}
		this._displayAsPassword = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._displayAsPassword;
	}

	/**
	 * @private
	 */
	private var _isEditable:Bool = true;

	/**
	 * Determines if the text input is editable. If the text input is not
	 * editable, it will still appear enabled.
	 *
	 * <p>In the following example, the text is not editable:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.isEditable = false;</listing>
	 *
	 * @default true
	 */
	public var isEditable(get, set):Bool;

	public function get_isEditable():Bool {
		return this._isEditable;
	}

	/**
	 * @private
	 */
	public function set_isEditable(value:Bool):Bool {
		if (this._isEditable == value) {
			return this._isEditable;
		}
		this._isEditable = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._isEditable;
	}

	/**
	 * @private
	 */
	private var _isSelectable:Bool = true;

	/**
	 * <p><strong>Warning:</strong> This property is ignored because
	 * <code>flash.text.StageText</code> does not support selectable text
	 * that is not editable.</p>
	 * 
	 * @copy feathers.controls.TextInput#isSelectable
	 *
	 * @see feathers.controls.TextInput#isSelectable
	 */
	public var isSelectable(get, set):Bool;

	public function get_isSelectable():Bool {
		return this._isSelectable;
	}

	/**
	 * @private
	 */
	public function set_isSelectable(value:Bool):Bool {
		if (this._isSelectable == value) {
			return this._isSelectable;
		}
		this._isSelectable = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._isSelectable;
	}

	/**
	 * @inheritDoc
	 *
	 * @default true
	 */
	public var setTouchFocusOnEndedPhase(get, never):Bool;

	public function get_setTouchFocusOnEndedPhase():Bool {
		return true;
	}

	/**
	 * @private
	 */
	private var _fontFamily:String = null;

	/**
	 * Indicates the name of the current font family. A value of null
	 * indicates the system default.
	 *
	 * <p>In the following example, the font family is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.fontFamily = "Source Sans Pro";</listing>
	 *
	 * @default null
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#fontFamily Full description of openfl.text.StageText.fontFamily in Adobe's Flash Platform API Reference
	 */
	public var fontFamily(get, set):String;

	public function get_fontFamily():String {
		return this._fontFamily;
	}

	/**
	 * @private
	 */
	public function set_fontFamily(value:String):String {
		if (this._fontFamily == value) {
			return this._fontFamily;
		}
		this._fontFamily = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._fontFamily;
	}

	/**
	 * @private
	 */
	#if flash
	private var _fontPosture:String = "normal" /*FontPosture.NORMAL*/;

	#end

	/**
	 * Specifies the font posture, using constants defined in the
	 * <code>openfl.text.engine.FontPosture</code> class.
	 *
	 * <p>In the following example, the font posture is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.fontPosture = FontPosture.ITALIC;</listing>
	 *
	 * @default openfl.text.engine.FontPosture.NORMAL
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#fontPosture Full description of openfl.text.StageText.fontPosture in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/engine/FontPosture.html openfl.text.engine.FontPosture
	 */
	#if flash
	public function get_fontPosture():String {
		return this._fontPosture;
	}
	#end

	/**
	 * @private
	 */
	#if flash
	public function set_fontPosture(value:String):String {
		if (this._fontPosture == value) {
			return get_fontPosture();
		}
		this._fontPosture = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return get_fontPosture();
	}
	#end

	/**
	 * @private
	 */
	private var _fontSize:Int = 12;

	/**
	 * The size in pixels for the current font family.
	 *
	 * <p>In the following example, the font size is increased to 16 pixels:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.fontSize = 16;</listing>
	 *
	 * @default 12
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#fontSize Full description of openfl.text.StageText.fontSize in Adobe's Flash Platform API Reference
	 */
	public var fontSize(get, set):Int;

	public function get_fontSize():Int {
		return this._fontSize;
	}

	/**
	 * @private
	 */
	public function set_fontSize(value:Int):Int {
		if (this._fontSize == value) {
			return this._fontSize;
		}
		this._fontSize = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._fontSize;
	}

	/**
	 * @private
	 */
	#if flash
	private var _fontWeight:String = "normal" /*FontWeight.NORMAL*/;

	#end

	/**
	 * Specifies the font weight, using constants defined in the
	 * <code>openfl.text.engine.FontWeight</code> class.
	 *
	 * <p>In the following example, the font weight is changed to bold:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.fontWeight = FontWeight.BOLD;</listing>
	 *
	 * @default openfl.text.engine.FontWeight.NORMAL
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#fontWeight Full description of openfl.text.StageText.fontWeight in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/engine/FontWeight.html openfl.text.engine.FontWeight
	 */
	#if flash
	public function get_fontWeight():String {
		return this._fontWeight;
	}
	#end

	/**
	 * @private
	 */
	#if flash
	public function set_fontWeight(value:String):String {
		if (this._fontWeight == value) {
			return get_fontWeight();
		}
		this._fontWeight = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return get_fontWeight();
	}
	#end

	/**
	 * @private
	 */
	private var _locale:String = "en";

	/**
	 * Indicates the locale of the text. <code>StageText</code> uses the
	 * standard locale identifiers. For example <code>"en"</code>,
	 * <code>"en_US"</code> and <code>"en-US"</code> are all English.
	 *
	 * <p>In the following example, the locale is changed to Russian:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.locale = "ru";</listing>
	 *
	 * @default "en"
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#locale Full description of openfl.text.StageText.locale in Adobe's Flash Platform API Reference
	 */
	public var locale(get, set):String;

	public function get_locale():String {
		return this._locale;
	}

	/**
	 * @private
	 */
	public function set_locale(value:String):String {
		if (this._locale == value) {
			return this._locale;
		}
		this._locale = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._locale;
	}

	/**
	 * @private
	 */
	private var _maxChars:Int = 0;

	/**
	 * Indicates the maximum number of characters that a user can enter into
	 * the text editor. A script can insert more text than <code>maxChars</code>
	 * allows. If <code>maxChars</code> equals zero, a user can enter an
	 * unlimited amount of text into the text editor.
	 *
	 * <p>In the following example, the maximum character count is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.maxChars = 10;</listing>
	 *
	 * @default 0
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#maxChars Full description of openfl.text.StageText.maxChars in Adobe's Flash Platform API Reference
	 */
	public var maxChars(get, set):Int;

	public function get_maxChars():Int {
		return this._maxChars;
	}

	/**
	 * @private
	 */
	public function set_maxChars(value:Int):Int {
		if (this._maxChars == value) {
			return this._maxChars;
		}
		this._maxChars = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._maxChars;
	}

	/**
	 * @private
	 */
	private var _multiline:Bool = false;

	/**
	 * Indicates whether the StageText object can display more than one line
	 * of text. This property is configurable after the text editor is
	 * created, unlike a regular <code>StageText</code> instance. The text
	 * editor will dispose and recreate its internal <code>StageText</code>
	 * instance if the value of the <code>multiline</code> property is
	 * changed after the <code>StageText</code> is initially created.
	 *
	 * <p>In the following example, multiline is enabled:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.multiline = true;</listing>
	 *
	 * When setting this property to <code>true</code>, it is recommended
	 * that the text input's <code>verticalAlign</code> property is set to
	 * <code>TextInput.VERTICAL_ALIGN_JUSTIFY</code>.
	 *
	 * @default false
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#multiline Full description of openfl.text.StageText.multiline in Adobe's Flash Platform API Reference
	 */
	public var multiline(get, set):Bool;

	public function get_multiline():Bool {
		return this._multiline;
	}

	/**
	 * @private
	 */
	public function set_multiline(value:Bool):Bool {
		if (this._multiline == value) {
			return this._multiline;
		}
		this._multiline = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._multiline;
	}

	/**
	 * @private
	 */
	// variable named "_restrict" generates compile error on hxcpp
	// private var _restrict:String;
	private var _restrict_:String;

	/**
	 * <p>This property is managed by the <code>TextInput</code>.</p>
	 * 
	 * @copy feathers.controls.TextInput#restrict
	 *
	 * @see feathers.controls.TextInput#restrict
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#restrict Full description of flash.text.StageText.restrict in Adobe's Flash Platform API Reference
	 */
	public var restrict(get, set):String;

	public function get_restrict():String {
		return this._restrict_;
	}

	/**
	 * @private
	 */
	public function set_restrict(value:String):String {
		if (this._restrict_ == value) {
			return this._restrict_;
		}
		this._restrict_ = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._restrict_;
	}

	/**
	 * @private
	 */
	private var _returnKeyLabel:String = "default";

	/**
	 * Indicates the label on the Return key for devices that feature a soft
	 * keyboard. The available values are constants defined in the
	 * <code>openfl.text.ReturnKeyLabel</code> class. This property is only a
	 * hint to the underlying platform, because not all devices and
	 * operating systems support this functionality.
	 *
	 * <p>In the following example, the return key label is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.returnKeyLabel = ReturnKeyLabel.GO;</listing>
	 *
	 * @default openfl.text.ReturnKeyLabel.DEFAULT
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#returnKeyLabel Full description of openfl.text.StageText.returnKeyLabel in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/ReturnKeyLabel.html openfl.text.ReturnKeyLabel
	 */
	public var returnKeyLabel(get, set):String;

	public function get_returnKeyLabel():String {
		return this._returnKeyLabel;
	}

	/**
	 * @private
	 */
	public function set_returnKeyLabel(value:String):String {
		if (this._returnKeyLabel == value) {
			return this._returnKeyLabel;
		}
		this._returnKeyLabel = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._returnKeyLabel;
	}

	/**
	 * @private
	 */
	private var _softKeyboardType:String = "default";

	/**
	 * Controls the appearance of the soft keyboard. Valid values are
	 * defined as constants in the <code>openfl.text.SoftKeyboardType</code>
	 * class. This property is only a hint to the underlying platform,
	 * because not all devices and operating systems support this
	 * functionality.
	 *
	 * <p>In the following example, the soft keyboard type is changed:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.softKeyboardType = SoftKeyboardType.NUMBER;</listing>
	 *
	 * @default openfl.text.SoftKeyboardType.DEFAULT
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#softKeyboardType Full description of openfl.text.StageText.softKeyboardType in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/SoftKeyboardType.html openfl.text.SoftKeyboardType
	 */
	public var softKeyboardType(get, set):String;

	public function get_softKeyboardType():String {
		return this._softKeyboardType;
	}

	/**
	 * @private
	 */
	public function set_softKeyboardType(value:String):String {
		if (this._softKeyboardType == value) {
			return this._softKeyboardType;
		}
		this._softKeyboardType = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._softKeyboardType;
	}

	/**
	 * @private
	 */
	private var _textAlign:String;

	/**
	 * Indicates the paragraph alignment. Valid values are defined as
	 * constants in the <code>flash.text.TextFormatAlign</code> class.
	 *
	 * <p>In the following example, the text is centered:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.textAlign = TextFormatAlign.CENTER;</listing>
	 *
	 * @default flash.text.TextFormatAlign.START
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#textAlign Full description of flash.text.StageText.textAlign in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormatAlign.html flash.text.TextFormatAlign
	 */
	public var textAlign(get, set):String;

	public function get_textAlign():String {
		return this._textAlign;
	}

	/**
	 * @private
	 */
	public function set_textAlign(value:String):String {
		if (this._textAlign == value) {
			return this._textAlign;
		}
		this._textAlign = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._textAlign;
	}

	/**
	 * @private
	 */
	private var _maintainTouchFocus:Bool = false;

	/**
	 * If enabled, the text editor will remain in focus, even if something
	 * else is touched.
	 *
	 * <p>Note: If the <code>FocusManager</code> is enabled, this property
	 * will be ignored.</p>
	 *
	 * <p>In the following example, touch focus is maintained:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.maintainTouchFocus = true;</listing>
	 *
	 * @default false
	 */
	public var maintainTouchFocus(get, set):Bool;

	override public function get_maintainTouchFocus():Bool {
		return this._maintainTouchFocus;
	}

	/**
	 * @private
	 */
	public function set_maintainTouchFocus(value:Bool):Bool {
		this._maintainTouchFocus = value;
		return this._maintainTouchFocus;
	}

	/**
	 * @private
	 */
	private var _lastGlobalScaleX:Float = 0;

	/**
	 * @private
	 */
	private var _lastGlobalScaleY:Float = 0;

	/**
	 * @private
	 */
	private var _updateSnapshotOnScaleChange:Bool = false;

	/**
	 * Refreshes the texture snapshot every time that the text editor is
	 * scaled. Based on the scale in global coordinates, so scaling the
	 * parent will require a new snapshot.
	 *
	 * <p>Warning: setting this property to true may result in reduced
	 * performance because every change of the scale requires uploading a
	 * new texture to the GPU. Use with caution. Consider setting this
	 * property to false temporarily during animations that modify the
	 * scale.</p>
	 *
	 * <p>In the following example, the snapshot will be updated when the
	 * text editor is scaled:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.updateSnapshotOnScaleChange = true;</listing>
	 *
	 * @default false
	 */
	public var updateSnapshotOnScaleChange(get, set):Bool;

	public function get_updateSnapshotOnScaleChange():Bool {
		return this._updateSnapshotOnScaleChange;
	}

	/**
	 * @private
	 */
	public function set_updateSnapshotOnScaleChange(value:Bool):Bool {
		if (this._updateSnapshotOnScaleChange == value) {
			return get_updateSnapshotOnScaleChange();
		}
		this._updateSnapshotOnScaleChange = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		return get_updateSnapshotOnScaleChange();
	}

	/**
	 * @private
	 * The default value doesn't use the constant because it's available in
	 * AIR only, and not Flash Player.
	 */
	private var _clearButtonMode:String = "whileEditing";

	/**
	 * Determines when the clear button is displayed or hidden by the
	 * <code>StageText</code> object.
	 *
	 * <p>In the following example, the clear button is always hidden:</p>
	 *
	 * <listing version="3.0">
	 * textEditor.clearButtonMode = StageTextClearButtonMode.NEVER;</listing>
	 * 
	 * <p>Requires <code>-swf-version=34</code> or newer.</p>
	 *
	 * @default flash.text.StageTextClearButtonMode.WHILE_EDITING
	 * 
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageText.html#clearButtonMode Full description of flash.text.StageText.clearButtonMode in Adobe's Flash Platform API Reference
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/StageTextClearButtonMode.html Full description of flash.text.StageTextClearButtonMode in Adobe's Flash Platform API Reference
	 */
	public var clearButtonMode(get, set):String;

	public function get_clearButtonMode():String {
		return this._clearButtonMode;
	}

	/**
	 * @private
	 */
	public function set_clearButtonMode(value:String):String {
		if (this._clearButtonMode == value) {
			return this._clearButtonMode;
		}
		this._clearButtonMode = value;
		this.invalidate(FeathersControl.INVALIDATION_FLAG_STYLES);
		return this._clearButtonMode;
	}

	/**
	 * @private
	 */
	override public function dispose():Void {
		if (this._measureTextField != null) {
			var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
			starling.nativeStage.removeChild(this._measureTextField);
			this._measureTextField = null;
		}

		if (this.stageText) {
			this.disposeStageText();
		}

		if (this.textSnapshot != null) {
			// avoid the need to call dispose(). we'll create a new snapshot
			// when the renderer is added to stage again.
			this.textSnapshot.texture.dispose();
			this.removeChild(this.textSnapshot, true);
			this.textSnapshot = null;
		}

		super.dispose();
	}

	/**
	 * @private
	 */
	override public function render(painter:Painter):Void {
		if (this._stageTextHasFocus) {
			painter.excludeFromCache(this);
		}

		if (this.textSnapshot != null && this._updateSnapshotOnScaleChange) {
			var matrix:Matrix = Pool.getMatrix();
			this.getTransformationMatrix(this.stage, matrix);
			if (FeathersGeomUtils.matrixToScaleX(matrix) != this._lastGlobalScaleX
				|| FeathersGeomUtils.matrixToScaleY(matrix) != this._lastGlobalScaleY) {
				// the snapshot needs to be updated because the scale has
				// changed since the last snapshot was taken.
				this.invalidate(FeathersControl.INVALIDATION_FLAG_SIZE);
				this.validate();
			}
			Pool.putMatrix(matrix);
		}
		if (this._needsTextureUpdate) {
			this._needsTextureUpdate = false;
			var hasText:Bool = this._text.length > 0;
			if (hasText) {
				this.refreshSnapshot();
			}
			if (this.textSnapshot != null) {
				this.textSnapshot.visible = !this._stageTextHasFocus;
				this.textSnapshot.alpha = hasText ? 1 : 0;
			}
			if (!this._stageTextHasFocus) {
				// hide the StageText after the snapshot is created
				// native controls don't necessarily render at the same time
				// as starling, and we don't want to see the text disappear
				// for a moment
				this.stageText.visible = false;
			}
		}

		// we'll skip this if the text field isn't visible to avoid running
		// that code every frame.
		if (this.stageText != null && this.stageText.visible) {
			this.refreshViewPortAndFontSize();
		}

		if (this.textSnapshot != null) {
			this.positionSnapshot();
		}

		super.render(painter);
	}

	/**
	 * @inheritDoc
	 */
	public function setFocus(position:Point = null):Void {
		// setting the editable property of a StageText to false seems to be
		// ignored on Android, so this is the workaround
		if (!this._isEditable && SystemUtil.platform == "AND") {
			return;
		}
		if (!this._isEditable && !this._isSelectable) {
			return;
		}
		if (this.stage != null && this.stageText.stage == null) {
			var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
			this.stageText.stage = starling.nativeStage;
		}
		if (this.stageText && this._stageTextIsComplete) {
			if (position != null) {
				var positionX:Float = position.x + 2;
				var positionY:Float = position.y + 2;
				if (positionX < 0) {
					this._pendingSelectionBeginIndex = this._pendingSelectionEndIndex = 0;
				} else {
					this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX, positionY);
					if (this._pendingSelectionBeginIndex < 0) {
						if (this._multiline) {
							var lineIndex:Int = Std.int(positionY / this._measureTextField.getLineMetrics(0).height);
							try {
								this._pendingSelectionBeginIndex = this._measureTextField.getLineOffset(lineIndex)
									+ this._measureTextField.getLineLength(lineIndex);
								if (this._pendingSelectionBeginIndex != this._text.length) {
									this._pendingSelectionBeginIndex--;
								}
							} catch (error:Error) {
								// we may be checking for a line beyond the
								// end that doesn't exist
								this._pendingSelectionBeginIndex = this._text.length;
							}
						} else {
							this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX,
								this._measureTextField.getLineMetrics(0).ascent / 2);
							if (this._pendingSelectionBeginIndex < 0) {
								this._pendingSelectionBeginIndex = this._text.length;
							}
						}
					} else {
						var bounds:Rectangle = this._measureTextField.getCharBoundaries(this._pendingSelectionBeginIndex);
						var boundsX:Float = bounds.x;
						if (bounds != null && (boundsX + bounds.width - positionX) < (positionX - boundsX)) {
							this._pendingSelectionBeginIndex++;
						}
					}
					this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
				}
			} else {
				this._pendingSelectionBeginIndex = this._pendingSelectionEndIndex = -1;
			}
			this.stageText.visible = true;
			if (!this._isEditable) {
				// assignFocus() does not work unless the StageText's
				// editable property is true, but we want the text to be
				// selectable. as a workaround, we temporarily set editable
				// to true before calling assignFocus(). once the StageText
				// has focus, we'll set it back to false.
				this.stageText.editable = true;
			}
			if (!this._stageTextHasFocus) {
				// on iOS, calling assignFocus() when the StageText already
				// has focus seems to make it harder to change the selection
				// with a touch and hold gesture. the soft keyboard appears
				// to close and re-open on touch begin more often.
				this.stageText.assignFocus();
			}
		} else {
			this._isWaitingToSetFocus = true;
		}
	}

	/**
	 * @inheritDoc
	 */
	public function clearFocus():Void {
		if (!this._stageTextHasFocus) {
			return;
		}
		var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
		// setting the focus to Starling.current.nativeStage doesn't work
		// here, so we need to use null. on Android, if we give focus to the
		// nativeStage, focus will be removed from the StageText, but the
		// soft keyboard will incorrectly remain open.
		starling.nativeStage.focus = null;
		if (!this.isParentChainVisible()) {
			// this normally happens in render(), but if we're not visible,
			// we need to hide the StageText manually.
			this.stageText.visible = false;
		}
	}

	/**
	 * @inheritDoc
	 */
	public function selectRange(beginIndex:Int, endIndex:Int):Void {
		if (this._stageTextIsComplete && this.stageText) {
			this._pendingSelectionBeginIndex = -1;
			this._pendingSelectionEndIndex = -1;
			this.stageText.selectRange(beginIndex, endIndex);
		} else {
			this._pendingSelectionBeginIndex = beginIndex;
			this._pendingSelectionEndIndex = endIndex;
		}
	}

	/**
	 * @inheritDoc
	 */
	public function measureText(result:Point = null):Point {
		if (result == null) {
			result = new Point();
		}

		var needsWidth:Bool = this._explicitWidth != this._explicitWidth; // isNaN
		var needsHeight:Bool = this._explicitHeight != this._explicitHeight; // isNaN
		if (!needsWidth && !needsHeight) {
			result.x = this._explicitWidth;
			result.y = this._explicitHeight;
			return result;
		}

		// if a parent component validates before we're added to the stage,
		// measureText() may be called before initialization, so we need to
		// force it.
		if (!this._isInitialized) {
			this.initializeNow();
		}

		var stylesInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_STYLES);
		var dataInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_DATA);

		if (stylesInvalid || dataInvalid) {
			this.refreshMeasureProperties();
		}

		result = this.measure(result);

		return result;
	}

	/**
	 * @private
	 */
	override private function initialize():Void {
		var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
		if (this._measureTextField != null && this._measureTextField.parent == null) {
			starling.nativeStage.addChild(this._measureTextField);
		} else if (this._measureTextField == null) {
			this._measureTextField = new TextField();
			this._measureTextField.visible = false;
			#if flash
			this._measureTextField.mouseEnabled = this._measureTextField.mouseWheelEnabled = false;
			#else
			this._measureTextField.mouseEnabled = false;
			#end
			this._measureTextField.autoSize = TextFieldAutoSize.LEFT;
			this._measureTextField.multiline = false;
			this._measureTextField.wordWrap = false;
			this._measureTextField.embedFonts = false;
			this._measureTextField.defaultTextFormat = new openfl.text.TextFormat(null, 11, 0x000000, false, false, false);
			starling.nativeStage.addChild(this._measureTextField);
		}

		this.createStageText();
	}

	/**
	 * @private
	 */
	override private function draw():Void {
		var sizeInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE);

		this.commit();

		sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

		this.layout(sizeInvalid);
	}

	/**
	 * @private
	 */
	private function commit():Void {
		var stateInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_STATE);
		var stylesInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_STYLES);
		var dataInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_DATA);

		if (stylesInvalid || dataInvalid) {
			this.refreshMeasureProperties();
		}

		var oldIgnoreStageTextChanges:Bool = this._ignoreStageTextChanges;
		this._ignoreStageTextChanges = true;
		if (stateInvalid || stylesInvalid) {
			this.refreshStageTextProperties();
		}

		if (dataInvalid) {
			if (this.stageText.text != this._text) {
				if (this._pendingSelectionBeginIndex < 0) {
					this._pendingSelectionBeginIndex = this.stageText.selectionActiveIndex;
					this._pendingSelectionEndIndex = this.stageText.selectionAnchorIndex;
				}
				this.stageText.text = this._text;
			}
		}
		this._ignoreStageTextChanges = oldIgnoreStageTextChanges;

		if (stylesInvalid || stateInvalid) {
			this.stageText.editable = this._isEditable && this._isEnabled;
		}
	}

	/**
	 * @private
	 */
	private function measure(result:Point = null):Point {
		if (result == null) {
			result = new Point();
		}

		var needsWidth:Bool = this._explicitWidth != this._explicitWidth; // isNaN
		var needsHeight:Bool = this._explicitHeight != this._explicitHeight; // isNaN

		this._measureTextField.autoSize = TextFieldAutoSize.LEFT;

		var newWidth:Float = this._explicitWidth;
		if (needsWidth) {
			newWidth = this._measureTextField.textWidth;
			if (newWidth < this._explicitMinWidth) {
				newWidth = this._explicitMinWidth;
			} else if (newWidth > this._explicitMaxWidth) {
				newWidth = this._explicitMaxWidth;
			}
		}

		// the +4 is accounting for the TextField gutter
		this._measureTextField.width = newWidth + 4;
		var newHeight:Float = this._explicitHeight;
		if (needsHeight) {
			if (this._stageTextIsTextField) {
				// we know that the StageText implementation is using
				// TextField internally, so textHeight will be accurate.
				newHeight = this._measureTextField.textHeight;
			} else {
				// since we're measuring with TextField, but rendering with
				// StageText, we're using height instead of textHeight here to be
				// sure that the measured size is on the larger side, in case the
				// rendered size is actually bigger than textHeight
				// if only StageText had an API for text measurement, we wouldn't
				// be in this mess...
				newHeight = this._measureTextField.height;
			}
			if (newHeight < this._explicitMinHeight) {
				newHeight = this._explicitMinHeight;
			} else if (newHeight > this._explicitMaxHeight) {
				newHeight = this._explicitMaxHeight;
			}
		}

		this._measureTextField.autoSize = TextFieldAutoSize.NONE;

		// put the width and height back just in case we measured without
		// a full validation
		// the +4 is accounting for the TextField gutter
		this._measureTextField.width = this.actualWidth + 4;
		this._measureTextField.height = this.actualHeight;

		result.x = newWidth;
		result.y = newHeight;

		return result;
	}

	/**
	 * @private
	 */
	private function layout(sizeInvalid:Bool):Void {
		var stateInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_STATE);
		var stylesInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_STYLES);
		var dataInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_DATA);
		var skinInvalid:Bool = this.isInvalid(FeathersControl.INVALIDATION_FLAG_SKIN);

		if (sizeInvalid || stylesInvalid || skinInvalid || stateInvalid) {
			var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
			this.refreshViewPortAndFontSize();
			this.refreshMeasureTextFieldDimensions();
			var viewPort:Rectangle = this.stageText.viewPort;
			var textureRoot:ConcreteTexture = this.textSnapshot != null ? this.textSnapshot.texture.root : null;
			this._needsNewTexture = this._needsNewTexture
				|| this.textSnapshot == null
				|| (textureRoot != null
					&& (textureRoot.scale != starling.contentScaleFactor
						|| viewPort.width != textureRoot.nativeWidth
						|| viewPort.height != textureRoot.nativeHeight));
		}

		if (!this._stageTextHasFocus && (stateInvalid || stylesInvalid || dataInvalid || sizeInvalid || this._needsNewTexture)) {
			if (!this.isParentChainVisible()) {
				// issue #1620
				// our parent has been hidden, so our render() method won't
				// be called, and we need to hide the StageText.
				this.stageText.visible = false;
			}
			// we're going to update the texture in render() because
			// there's a chance that it will be updated more than once per
			// frame if we do it here.
			this._needsTextureUpdate = true;
			this.setRequiresRedraw();
		}

		this.doPendingActions();
	}

	/**
	 * If the component's dimensions have not been set explicitly, it will
	 * measure its content and determine an ideal size for itself. If the
	 * <code>explicitWidth</code> or <code>explicitHeight</code> member
	 * variables are set, those value will be used without additional
	 * measurement. If one is set, but not the other, the dimension with the
	 * explicit value will not be measured, but the other non-explicit
	 * dimension will still need measurement.
	 *
	 * <p>Calls <code>saveMeasurements()</code> to set up the
	 * <code>actualWidth</code> and <code>actualHeight</code> member
	 * variables used for layout.</p>
	 *
	 * <p>Meant for internal use, and subclasses may override this function
	 * with a custom implementation.</p>
	 */
	private function autoSizeIfNeeded():Bool {
		var needsWidth:Bool = this._explicitWidth != this._explicitWidth; // isNaN
		var needsHeight:Bool = this._explicitHeight != this._explicitHeight; // isNaN
		var needsMinWidth:Bool = this._explicitMinWidth != this._explicitMinWidth; // isNaN
		var needsMinHeight:Bool = this._explicitMinHeight != this._explicitMinHeight; // isNaN
		if (!needsWidth && !needsHeight && !needsMinWidth && !needsMinHeight) {
			return false;
		}

		var point:Point = Pool.getPoint();
		this.measure(point);
		var result:Bool = this.saveMeasurements(point.x, point.y, point.x, point.y);
		Pool.putPoint(point);
		return result;
	}

	/**
	 * @private
	 */
	private function refreshMeasureProperties():Void {
		this._measureTextField.displayAsPassword = this._displayAsPassword;
		this._measureTextField.maxChars = this._maxChars;
		this._measureTextField.restrict = this._restrict_;
		this._measureTextField.multiline = this._multiline;
		this._measureTextField.wordWrap = this._multiline;
		var measureFormat:openfl.text.TextFormat = this._measureTextField.defaultTextFormat;
		var fontStylesFormat:starling.text.TextFormat = null;
		if (this._fontStyles != null) {
			fontStylesFormat = this._fontStyles.getTextFormatForTarget(this);
		}

		if (this._fontFamily != null) {
			measureFormat.font = this._fontFamily;
		} else if (fontStylesFormat != null) {
			measureFormat.font = fontStylesFormat.font;
		} else {
			measureFormat.font = null;
		}

		if (this._fontSize > 0) {
			measureFormat.size = this._fontSize;
		} else if (fontStylesFormat != null) {
			measureFormat.size = Std.int(fontStylesFormat.size);
		} else {
			measureFormat.size = 12;
		}
		#if flash
		if (this._fontWeight != null) {
			measureFormat.bold = this._fontWeight == "bold" /*FontWeight.BOLD*/;
		}
		#else
		if (fontStylesFormat != null) {
			measureFormat.bold = fontStylesFormat.bold;
		} else {
			measureFormat.bold = false;
		}
		#end
		#if flash
		if (this._fontPosture != null) {
			measureFormat.italic = this._fontPosture == "italic" /*FontPosture.ITALIC*/;
		}
		#else
		if (fontStylesFormat != null) {
			measureFormat.italic = fontStylesFormat.italic;
		} else {
			measureFormat.italic = false;
		}
		#end

		// color and alignment are ignored because they don't affect
		// measurement

		this._measureTextField.defaultTextFormat = measureFormat;
		this._measureTextField.setTextFormat(measureFormat);
		if (this._text.length == 0) {
			this._measureTextField.text = " ";
		} else {
			this._measureTextField.text = this._text;
		}
	}

	/**
	 * @private
	 */
	private function refreshStageTextProperties():Void {
		if (this.stageText.multiline != this._multiline) {
			if (this.stageText != null) {
				this.disposeStageText();
			}
			this.createStageText();
		}

		var textFormat:starling.text.TextFormat = null;
		if (this._fontStyles != null) {
			textFormat = this._fontStyles.getTextFormatForTarget(this);
		}
		this.stageText.autoCapitalize = this._autoCapitalize;
		this.stageText.autoCorrect = this._autoCorrect;
		if (this._isEnabled) {
			if (this._color == 0xFFFFFFFF) {
				if (textFormat != null) {
					this.stageText.color = textFormat.color;
				} else {
					this.stageText.color = 0x000000;
				}
			} else {
				this.stageText.color = this._color;
			}
		} else // disabled
		{
			if (this._disabledColor == 0xFFFFFFFF) {
				if (this._color == 0xFFFFFFFF) {
					if (textFormat != null) {
						this.stageText.color = textFormat.color;
					} else {
						this.stageText.color = 0x000000;
					}
				} else {
					this.stageText.color = this._color;
				}
			} else {
				this.stageText.color = this._disabledColor;
			}
		}
		this.stageText.displayAsPassword = this._displayAsPassword;
		var fontFamily:String = this._fontFamily;
		if (fontFamily == null && textFormat != null) {
			fontFamily = textFormat.font;
		} // default to null
		this.stageText.fontFamily = fontFamily;
		#if flash
		var fontPosture:String = this._fontPosture;
		if (fontPosture == null) {
			if (textFormat != null && textFormat.italic) {
				fontPosture = "italic" /*FontPosture.ITALIC*/;
			} else {
				fontPosture = "normal" /* FontPosture.NORMAL */;
			}
		}
		this.stageText.fontPosture = fontPosture;
		var fontWeight:String = this._fontWeight;
		if (fontWeight == null) {
			if (textFormat != null && textFormat.bold) {
				fontWeight = "bold" /* FontWeight.BOLD */;
			} else {
				fontWeight = "normal" /* FontWeight.NORMAL */;
			}
		}
		this.stageText.fontWeight = fontWeight;
		#end
		this.stageText.locale = this._locale;
		this.stageText.maxChars = this._maxChars;
		this.stageText.restrict = this._restrict_;
		this.stageText.returnKeyLabel = this._returnKeyLabel;
		this.stageText.softKeyboardType = this._softKeyboardType;
		var textAlign:String = this._textAlign;
		if (textAlign == null) {
			if (textFormat != null && textFormat.horizontalAlign != null) {
				textAlign = textFormat.horizontalAlign;
			} else {
				textAlign = "start" /* TextFormatAlign.START */;
			}
		}
		this.stageText.textAlign = textAlign;
		// if ("clearButtonMode" in this.stageText)
		if (Reflect.hasField(this.stageText, "clearButtonMode")) {
			this.stageText.clearButtonMode = this._clearButtonMode;
		}
	}

	/**
	 * @private
	 */
	private function doPendingActions():Void {
		if (this._isWaitingToSetFocus) {
			this._isWaitingToSetFocus = false;
			this.setFocus();
		}
		if (this._pendingSelectionBeginIndex >= 0) {
			var startIndex:Int = this._pendingSelectionBeginIndex;
			var endIndex:Int = (this._pendingSelectionEndIndex < 0) ? this._pendingSelectionBeginIndex : this._pendingSelectionEndIndex;
			this._pendingSelectionBeginIndex = -1;
			this._pendingSelectionEndIndex = -1;
			if (this.stageText.selectionAnchorIndex != startIndex || this.stageText.selectionActiveIndex != endIndex) {
				// if the same range is already selected, don't try to do it
				// again because on iOS, if the StageText is multiline, this
				// will cause the clipboard menu to appear when it shouldn't.
				this.selectRange(startIndex, endIndex);
			}
		}
	}

	/**
	 * @private
	 */
	private function texture_onRestore():Void {
		var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
		if (this.textSnapshot.texture.scale != starling.contentScaleFactor) {
			// if we've changed between scale factors, we need to recreate
			// the texture to match the new scale factor.
			this.invalidate(FeathersControl.INVALIDATION_FLAG_SIZE);
		} else {
			this.refreshSnapshot();
			if (this.textSnapshot != null) {
				this.textSnapshot.visible = !this._stageTextHasFocus;
				this.textSnapshot.alpha = this._text.length > 0 ? 1 : 0;
			}
			if (!this._stageTextHasFocus) {
				this.stageText.visible = false;
			}
		}
	}

	/**
	 * @private
	 */
	private function refreshSnapshot():Void {
		var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
		// StageText's stage property cannot be null when we call
		// drawViewPortToBitmapData()
		if (this.stage != null && this.stageText.stage == null) {
			this.stageText.stage = starling.nativeStage;
		}
		if (this.stageText.stage == null) {
			// we need to keep a flag active so that the snapshot will be
			// refreshed after the text editor is added to the stage
			this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
			return;
		}
		var viewPort:Rectangle = this.stageText.viewPort;
		if (viewPort.width == 0 || viewPort.height == 0) {
			return;
		}
		var nativeScaleFactor:Float = 1;
		#if flash
		if (starling.supportHighResolutions) {
			nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
		}
		#end
		// StageText sucks because it requires that the BitmapData's width
		// and height exactly match its view port width and height.
		// (may be doubled on Retina Mac)
		var bitmapData:BitmapData = null;
		try {
			bitmapData = new BitmapData(Std.int(viewPort.width * nativeScaleFactor), Std.int(viewPort.height * nativeScaleFactor), true, 0x00ff00ff);
			this.stageText.drawViewPortToBitmapData(bitmapData);
		} catch (error:Error) {
			// drawing stage text to the bitmap data at double size may fail
			// on runtime versions less than 15, so fall back to using a
			// snapshot that is half size. it's not ideal, but better than
			// nothing.
			bitmapData.dispose();
			bitmapData = new BitmapData(Std.int(viewPort.width), Std.int(viewPort.height), true, 0x00ff00ff);
			this.stageText.drawViewPortToBitmapData(bitmapData);
		}

		var newTexture:Texture = null;
		if (this.textSnapshot == null || this._needsNewTexture) {
			var scaleFactor:Float = starling.contentScaleFactor;
			// skip Texture.fromBitmapData() because we don't want
			// it to create an onRestore function that will be
			// immediately discarded for garbage collection.
			newTexture = Texture.empty(bitmapData.width / scaleFactor, bitmapData.height / scaleFactor, true, false, false, scaleFactor);
			newTexture.root.uploadBitmapData(bitmapData);
			newTexture.root.onRestore = cast texture_onRestore;
		}
		if (this.textSnapshot == null) {
			this.textSnapshot = new Image(newTexture);
			this.textSnapshot.pixelSnapping = true;
			this.addChild(this.textSnapshot);
		} else {
			if (this._needsNewTexture) {
				this.textSnapshot.texture.dispose();
				this.textSnapshot.texture = newTexture;
				this.textSnapshot.readjustSize();
			} else {
				// this is faster, if we haven't resized the bitmapdata
				var existingTexture:Texture = this.textSnapshot.texture;
				existingTexture.root.uploadBitmapData(bitmapData);
				// however, the image won't be notified that its
				// texture has changed, so we need to do it manually
				this.textSnapshot.setRequiresRedraw();
			}
		}
		var matrix:Matrix = Pool.getMatrix();
		this.getTransformationMatrix(this.stage, matrix);
		var globalScaleX:Float = FeathersGeomUtils.matrixToScaleX(matrix);
		var globalScaleY:Float = FeathersGeomUtils.matrixToScaleY(matrix);
		Pool.putMatrix(matrix);
		if (this._updateSnapshotOnScaleChange) {
			this.textSnapshot.scaleX = 1 / globalScaleX;
			this.textSnapshot.scaleY = 1 / globalScaleY;
			this._lastGlobalScaleX = globalScaleX;
			this._lastGlobalScaleY = globalScaleY;
		} else {
			this.textSnapshot.scaleX = 1;
			this.textSnapshot.scaleY = 1;
		}
		if (nativeScaleFactor > 1 && bitmapData.width == viewPort.width) {
			// when we fall back to using a snapshot that is half size on
			// older runtimes, we need to scale it up.
			this.textSnapshot.scaleX *= nativeScaleFactor;
			this.textSnapshot.scaleY *= nativeScaleFactor;
		}
		bitmapData.dispose();
		this._needsNewTexture = false;
	}

	/**
	 * @private
	 */
	private function refreshViewPortAndFontSize():Void {
		var matrix:Matrix = Pool.getMatrix();
		var point:Point = Pool.getPoint();
		var desktopGutterPositionOffset:Float = 0;
		var desktopGutterDimensionsOffset:Float = 0;
		if (this._stageTextIsTextField) {
			desktopGutterPositionOffset = 2;
			desktopGutterDimensionsOffset = 4;
		}
		this.getTransformationMatrix(this.stage, matrix);
		var globalScaleX:Float;
		var globalScaleY:Float;
		var smallerGlobalScale:Float;
		if (this._stageTextHasFocus || this._updateSnapshotOnScaleChange) {
			globalScaleX = FeathersGeomUtils.matrixToScaleX(matrix);
			globalScaleY = FeathersGeomUtils.matrixToScaleY(matrix);
			smallerGlobalScale = globalScaleX;
			if (globalScaleY < smallerGlobalScale) {
				smallerGlobalScale = globalScaleY;
			}
		} else {
			globalScaleX = 1;
			globalScaleY = 1;
			smallerGlobalScale = 1;
		}
		var verticalAlignOffsetY:Float = this.getVerticalAlignmentOffsetY();
		if (this.is3D) {
			var matrix3D:Matrix3D = Pool.getMatrix3D();
			var point3D:Vector3D = Pool.getPoint3D();
			this.getTransformationMatrix3D(this.stage, matrix3D);
			MatrixUtil.transformCoords3D(matrix3D, -desktopGutterPositionOffset, -desktopGutterPositionOffset + verticalAlignOffsetY, 0, point3D);
			point.setTo(point3D.x, point3D.y);
			Pool.putPoint3D(point3D);
			Pool.putMatrix3D(matrix3D);
		} else {
			MatrixUtil.transformCoords(matrix, -desktopGutterPositionOffset, -desktopGutterPositionOffset + verticalAlignOffsetY, point);
		}
		var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
		var nativeScaleFactor:Float = 1;
		#if flash
		if (starling.supportHighResolutions) {
			nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
		}
		#end
		var scaleFactor:Float = starling.contentScaleFactor / nativeScaleFactor;
		var starlingViewPort:Rectangle = starling.viewPort;
		var stageTextViewPort:Rectangle = this.stageText.viewPort;
		if (stageTextViewPort == null) {
			stageTextViewPort = new Rectangle();
		}
		var viewPortWidth:Float = Math.round((this.actualWidth + desktopGutterDimensionsOffset) * scaleFactor * globalScaleX);
		if (viewPortWidth < 1 || viewPortWidth != viewPortWidth) // isNaN
		{
			viewPortWidth = 1;
		}
		var viewPortHeight:Float = Math.round((this.actualHeight + desktopGutterDimensionsOffset) * scaleFactor * globalScaleY);
		if (viewPortHeight < 1 || viewPortHeight != viewPortHeight) // isNaN
		{
			viewPortHeight = 1;
		}
		stageTextViewPort.width = viewPortWidth;
		stageTextViewPort.height = viewPortHeight;
		var viewPortX:Float = Math.round(starlingViewPort.x + (point.x * scaleFactor));
		if ((viewPortX + viewPortWidth) > MAX_VIEW_PORT_POSITION) {
			viewPortX = MAX_VIEW_PORT_POSITION - viewPortWidth;
		}
		// the previous calculation may have pushed the value below the
		// minimum, so it shouldn't be else if (BowlerHatLLC/feathersui-starling#1779)
		if (viewPortX < MIN_VIEW_PORT_POSITION) {
			viewPortX = MIN_VIEW_PORT_POSITION;
		}
		var viewPortY:Float = Math.round(starlingViewPort.y + (point.y * scaleFactor));
		if ((viewPortY + viewPortHeight) > MAX_VIEW_PORT_POSITION) {
			viewPortY = MAX_VIEW_PORT_POSITION - viewPortHeight;
		}
		// the previous calculation may have pushed the value below the
		// minimum, so it shouldn't be else if (BowlerHatLLC/feathersui-starling#1779)
		if (viewPortY < MIN_VIEW_PORT_POSITION) {
			viewPortY = MIN_VIEW_PORT_POSITION;
		}
		stageTextViewPort.x = viewPortX;
		stageTextViewPort.y = viewPortY;
		this.stageText.viewPort = stageTextViewPort;

		var fontSize:Int = 12;
		if (this._fontSize > 0) {
			fontSize = this._fontSize;
		} else if (this._fontStyles != null) {
			var textFormat:starling.text.TextFormat = this._fontStyles.getTextFormatForTarget(this);
			if (textFormat != null) {
				fontSize = Std.int(textFormat.size);
			}
		}
		// StageText's fontSize property is an int, so we need to
		// specifically avoid using Number here.
		var newFontSize:Int = Std.int(fontSize * scaleFactor * smallerGlobalScale);
		if (this.stageText.fontSize != newFontSize) {
			// we need to check if this value has changed because on iOS
			// if displayAsPassword is set to true, the new character
			// will not be shown if the font size changes. instead, it
			// immediately changes to a bullet. (Github issue #881)
			this.stageText.fontSize = newFontSize;
		}
		Pool.putPoint(point);
		Pool.putMatrix(matrix);
	}

	/**
	 * @private
	 */
	private function refreshMeasureTextFieldDimensions():Void {
		// the +4 is accounting for the TextField gutter
		this._measureTextField.width = this.actualWidth + 4;
		this._measureTextField.height = this.actualHeight;
	}

	/**
	 * @private
	 */
	private function positionSnapshot():Void {
		var matrix:Matrix = Pool.getMatrix();
		this.getTransformationMatrix(this.stage, matrix);
		var desktopGutterPositionOffset:Float = 0;
		if (this._stageTextIsTextField) {
			desktopGutterPositionOffset = 2;
		}
		this.textSnapshot.x = Math.round(matrix.tx) - matrix.tx - desktopGutterPositionOffset;
		this.textSnapshot.y = Math.round(matrix.ty) - matrix.ty - desktopGutterPositionOffset + this.getVerticalAlignmentOffsetY();
		Pool.putMatrix(matrix);
	}

	/**
	 * @private
	 */
	private function disposeStageText():Void {
		if (this.stageText == null) {
			return;
		}
		this.stageText.removeEventListener(openfl.events.Event.CHANGE, stageText_changeHandler);
		this.stageText.removeEventListener(KeyboardEvent.KEY_DOWN, stageText_keyDownHandler);
		this.stageText.removeEventListener(KeyboardEvent.KEY_UP, stageText_keyUpHandler);
		this.stageText.removeEventListener(FocusEvent.FOCUS_IN, stageText_focusInHandler);
		this.stageText.removeEventListener(FocusEvent.FOCUS_OUT, stageText_focusOutHandler);
		this.stageText.removeEventListener(openfl.events.Event.COMPLETE, stageText_completeHandler);
		#if flash
		this.stageText.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, stageText_softKeyboardActivateHandler);
		this.stageText.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATING, stageText_softKeyboardActivatingHandler);
		this.stageText.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, stageText_softKeyboardDeactivateHandler);
		#end
		this.stageText.stage = null;
		this.stageText.dispose();
		this.stageText = null;
	}

	/**
	 * Creates and adds the <code>stageText</code> instance.
	 *
	 * <p>Meant for internal use, and subclasses may override this function
	 * with a custom implementation.</p>
	 */
	private function createStageText():Void {
		this._stageTextIsComplete = false;
		var StageTextType:Class<Dynamic>;
		var initOptions:Dynamic;
		#if flash
		try {
			StageTextType = Class(getDefinitionByName("openfl.text.StageText"));
			var StageTextInitOptionsType:Class = Class(getDefinitionByName("openfl.text.StageTextInitOptions"));
			initOptions = new StageTextInitOptionsType(this._multiline);
		} catch (error:Error)
		#end
		{
			StageTextType = StageTextField;
			initOptions = {multiline: this._multiline};
		}
		this.stageText = Type.createInstance(StageTextType, [initOptions]);
		this.stageText.visible = false;
		this.stageText.addEventListener(openfl.events.Event.CHANGE, stageText_changeHandler);
		this.stageText.addEventListener(KeyboardEvent.KEY_DOWN, stageText_keyDownHandler);
		this.stageText.addEventListener(KeyboardEvent.KEY_UP, stageText_keyUpHandler);
		this.stageText.addEventListener(FocusEvent.FOCUS_IN, stageText_focusInHandler);
		this.stageText.addEventListener(FocusEvent.FOCUS_OUT, stageText_focusOutHandler);
		#if flash
		this.stageText.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, stageText_softKeyboardActivateHandler);
		this.stageText.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATING, stageText_softKeyboardActivatingHandler);
		this.stageText.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, stageText_softKeyboardDeactivateHandler);
		#end
		this.stageText.addEventListener(openfl.events.Event.COMPLETE, stageText_completeHandler);
		this.stageText.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, stageText_mouseFocusChangeHandler);
		this.invalidate();
	}

	/**
	 * @private
	 */
	private function getVerticalAlignment():String {
		var verticalAlign:String = null;
		if (this._fontStyles != null) {
			var format:starling.text.TextFormat = this._fontStyles.getTextFormatForTarget(this);
			if (format != null) {
				verticalAlign = format.verticalAlign;
			}
		}
		if (verticalAlign == null) {
			verticalAlign = Align.TOP;
		}
		return verticalAlign;
	}

	/**
	 * @private
	 */
	private function getVerticalAlignmentOffsetY():Float {
		var verticalAlign:String = this.getVerticalAlignment();
		if (this._measureTextField.textHeight > this.actualHeight) {
			return 0;
		}
		if (verticalAlign == Align.BOTTOM) {
			return (this.actualHeight - this._measureTextField.textHeight);
		} else if (verticalAlign == Align.CENTER) {
			return (this.actualHeight - this._measureTextField.textHeight) / 2;
		}
		return 0;
	}

	/**
	 * @private
	 */
	private function dispatchKeyFocusChangeEvent(event:KeyboardEvent):Void {
		var focusEvent:FocusEvent = new FocusEvent(FocusEvent.KEY_FOCUS_CHANGE, true, false, null, event.shiftKey, event.keyCode);
		this.stage.starling.nativeStage.dispatchEvent(focusEvent);
	}

	/**
	 * @private
	 */
	private function dispatchKeyboardEventToStage(event:KeyboardEvent):Void {
		this.stage.starling.nativeStage.dispatchEvent(event);
	}

	/**
	 * @private
	 */
	private function isParentChainVisible():Bool {
		var target:DisplayObject = this;
		do {
			if (!target.visible) {
				return false;
			}
			target = target.parent;
		} while (target != null);
		return true;
	}

	/**
	 * @private
	 */
	private function textEditor_removedFromStageHandler(event:starling.events.Event):Void {
		// remove this from the stage, if needed
		// it will be added back next time we receive focus
		this.stageText.stage = null;
	}

	/**
	 * @private
	 */
	private function stageText_changeHandler(event:openfl.events.Event):Void {
		if (this._ignoreStageTextChanges) {
			return;
		}
		this.text = this.stageText.text;
	}

	/**
	 * @private
	 */
	private function stageText_completeHandler(event:openfl.events.Event):Void {
		this.stageText.removeEventListener(openfl.events.Event.COMPLETE, stageText_completeHandler);
		this.invalidate();

		this._stageTextIsComplete = true;
	}

	/**
	 * @private
	 */
	private function stageText_focusInHandler(event:FocusEvent):Void {
		this._stageTextHasFocus = true;
		if (!this._isEditable) {
			// see the other half of this hack in setFocus()
			this.stageText.editable = false;
		}
		this.addEventListener(starling.events.Event.ENTER_FRAME, hasFocus_enterFrameHandler);
		if (this.textSnapshot != null) {
			this.textSnapshot.visible = false;
		}
		this.invalidate(FeathersControl.INVALIDATION_FLAG_SKIN);
		this.dispatchEventWith(FeathersEventType.FOCUS_IN);
	}

	/**
	 * @private
	 */
	private function stageText_focusOutHandler(event:FocusEvent):Void {
		this._stageTextHasFocus = false;
		// since StageText doesn't expose its scroll position, we need to
		// set the selection back to the beginning to scroll there. it's a
		// hack, but so is everything about StageText.
		// in other news, why won't 0,0 work here?
		this.stageText.selectRange(1, 1);

		this.invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		this.invalidate(FeathersControl.INVALIDATION_FLAG_SKIN);
		this.dispatchEventWith(FeathersEventType.FOCUS_OUT);
	}

	/**
	 * @private
	 */
	private function hasFocus_enterFrameHandler(event:starling.events.Event):Void {
		if (this._stageTextHasFocus) {
			if (!this.isParentChainVisible()) {
				this.stageText.stage.focus = null;
			}
		} else {
			this.removeEventListener(starling.events.Event.ENTER_FRAME, hasFocus_enterFrameHandler);
		}
	}

	/**
	 * @private
	 */
	private function stageText_mouseFocusChangeHandler(event:FocusEvent):Void {
		var nativeStage:Stage = this.stage.starling.nativeStage;
		var point:Point = Pool.getPoint(nativeStage.mouseX, nativeStage.mouseY);
		FeathersUIUtils.nativeToGlobal(point, this.stage.starling, point);
		var result:DisplayObject = this.stage.hitTest(point);
		while (result != null) {
			var focusResult:IFocusDisplayObject = cast result;
			if (focusResult != null) {
				var focusOwner:IFocusDisplayObject = focusResult.focusOwner;
				if (focusOwner != null) {
					if (Std.isOfType(focusOwner, DisplayObjectContainer) && cast(focusOwner, DisplayObjectContainer).contains(this)) {
						// this mouseFocusChange event won't reach the native
						// stage, so the FocusManager can't prevent it
						event.preventDefault();
					}
					break;
				} else if (focusResult.isFocusEnabled) {
					break;
				}
			}
			result = result.parent;
		}
		if (!this._maintainTouchFocus) {
			return;
		}
		event.preventDefault();
	}

	/**
	 * @private
	 */
	private function stageText_keyDownHandler(event:KeyboardEvent):Void {
		#if flash
		if (!this._multiline && (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.NEXT)) {
			event.preventDefault();
			this.dispatchEventWith(FeathersEventType.ENTER);
		} else if (event.keyCode == Keyboard.BACK) {
			// even a listener on the stage won't detect the back key press that
			// will close the application if the StageText has focus, so we
			// always need to prevent it here
			event.preventDefault();
			var starling:Starling = this.stage != null ? this.stage.starling : Starling.current;
			starling.nativeStage.focus = starling.nativeStage;
		}
		if (FocusManager.isEnabledForStage(this.stage)) {
			if (event.keyCode == Keyboard.TAB) {
				event.preventDefault();
				this.dispatchKeyFocusChangeEvent(event);
			}
			if ((event.keyLocation == KeyLocation.D_PAD || DeviceCapabilities.simulateDPad)
				&& (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)) {
				event.preventDefault();
				this.dispatchKeyboardEventToStage(event);
			}
		}
		#end
	}

	/**
	 * @private
	 */
	private function stageText_keyUpHandler(event:KeyboardEvent):Void {
		#if flash
		if (!this._multiline && (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.NEXT)) {
			event.preventDefault();
		}
		if (event.keyCode == Keyboard.TAB && FocusManager.isEnabledForStage(this.stage)) {
			event.preventDefault();
		}
		#end
	}

	/**
	 * @private
	 */
	#if flash
	private function stageText_softKeyboardActivateHandler(event:SoftKeyboardEvent):Void {
		this.dispatchEventWith(FeathersEventType.SOFT_KEYBOARD_ACTIVATE, true);
	}
	#end

	/**
	 * @private
	 */
	#if flash
	private function stageText_softKeyboardActivatingHandler(event:SoftKeyboardEvent):Void {
		this.dispatchEventWith(FeathersEventType.SOFT_KEYBOARD_ACTIVATING, true);
	}
	#end

	/**
	 * @private
	 */
	#if flash
	private function stageText_softKeyboardDeactivateHandler(event:SoftKeyboardEvent):Void {
		this.dispatchEventWith(FeathersEventType.SOFT_KEYBOARD_DEACTIVATE, true);
	}
	#end
}
