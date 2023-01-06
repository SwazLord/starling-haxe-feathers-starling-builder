/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */

package starlingbuilder.engine;

import openfl.Lib;
import openfl.geom.Rectangle;
import haxe.Json;
import openfl.errors.Error;
import starlingbuilder.engine.format.DefaultDataFormatter;
import starlingbuilder.engine.format.IDataFormatter;
import starlingbuilder.engine.localization.DefaultLocalizationHandler;
import starlingbuilder.engine.localization.ILocalization;
import starlingbuilder.engine.localization.ILocalizationHandler;
import starlingbuilder.engine.tween.ITweenBuilder;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

/**
 * Main class of Starling Builder engine API
 *
 * <p>Exmaple of creating a UIBuilder</p>
 *
 * <listing version="3.0">
 *     var assetManager:AssetManager = new AssetManager();
 *     var assetMediator:AssetMediator = new AssetMediator(assetManager);
 *     var uiBuilder:UIBuilder = new UIBuilder(assetMediator);</listing>
 *
 *
 * <p>A simple example to create display objects from layout</p>
 *
 * <listing version="3.0">
 *     var sprite:Sprite = uiBuilder.create(layoutData) as Sprite;
 *     addChild(sprite);</listing>
 *
 * <p>A more elaborate way to create UI element inside a class, and bind the public underscore property automatically</p>
 *
 * <listing version="3.0">
 *     public class MailPopup extends Sprite
 *     {
 *         //auto bind variables
 *         public var _list:List;
 *         public var _exitButton:Button;
 *         <br>
 *         public function MailPopup()
 *         {
 *             super();
 *             <br>
 *             var sprite:Sprite = uiBuilder.create(ParsedLayouts.mail_popup, true, this) as Sprite;
 *             addChild(sprite);
 *             <br>
 *             _exitButton.addEventListener(Event.TRIGGERED, onExit);
 *         }
 *         <br>
 *         private function onExit(event:Event):Void
 *         {
 *             PopUpManager.removePopUp(this, true);
 *         }
 *     }</listing>
 *
 * @see http://wiki.starling-framework.org/builder/start Starling Builder wiki page
 * @see http://github.com/mindjolt/starling-builder-engine/tree/master/demo Starling Builder demo project
 * @see http://github.com/mindjolt/starling-builder-engine/tree/master/scaffold Starling Builder scaffold project
 *
 */
class UIBuilder implements IUIBuilder {
	private var _assetMediator:IAssetMediator;

	private var _dataFormatter:IDataFormatter;

	private var _factory:UIElementFactory;

	private var _forEditor:Bool;

	private var _template:Dynamic;

	private var _localization:ILocalization;

	private var _localizationHandler:ILocalizationHandler;

	private var _displayObjectHandler:IDisplayObjectHandler;

	private var _tweenBuilder:ITweenBuilder;

	private var paramsDict:Map<DisplayObject, Dynamic>;

	/**
	 * Constructor
	 * @param assetMediator asset mediator
	 * @param forEditor whether it's used for the editor
	 * @param template template for saving layout
	 * @param localization optional localization instance
	 * @param tweenBuilder optional tween builder instance
	 */
	public var prettyData(get, set):Bool;

	public function get_prettyData():Bool {
		return this._dataFormatter.prettyData;
	}

	public function set_prettyData(value:Bool):Bool {
		return this._dataFormatter.prettyData = value;
	}

	public function new(assetMediator:IAssetMediator, forEditor:Bool = false, template:Dynamic = null, localization:ILocalization = null,
			tweenBuilder:ITweenBuilder = null) {
		_assetMediator = assetMediator;
		_dataFormatter = new DefaultDataFormatter();
		_factory = new UIElementFactory(_assetMediator);
		_forEditor = forEditor;
		_template = template;
		_localization = localization;
		_localizationHandler = new DefaultLocalizationHandler();
		_tweenBuilder = tweenBuilder;
	}

	/**
	 * @copy IUIBuilder#load()
	 * @see #create()
	 */
	public function load(data:Dynamic, trimLeadingSpace:Bool = true, binder:Dynamic = null):Dynamic {
		trace("called load");
		if (_dataFormatter != null)
			data = _dataFormatter.read(data);

		paramsDict = new Map<DisplayObject, Dynamic>();

		var root:DisplayObject = loadTree(data.layout, _factory, paramsDict);

		if (trimLeadingSpace && Std.isOfType(root, DisplayObjectContainer))
			doTrimLeadingSpace(cast root);

		localizeTexts(root, paramsDict);

		if (binder) {
			trace("paramsDict length = " + Lambda.count(paramsDict));
			bind(binder, paramsDict);
		}

		return {object: root, params: paramsDict, data: data};
	}

	private function loadTree(data:Dynamic, factory:UIElementFactory, paramsDict:Map<DisplayObject, Dynamic>):DisplayObject {
		// trace("called loadTree with data" + data);
		var obj:DisplayObject = cast(factory.create(data), DisplayObject);
		paramsDict[obj] = data;
		trace("paramsDict length = " + Lambda.count(paramsDict));
		// trace("paramsDict keys = " + paramsDict.keys());
		/* for (obj in paramsDict.keys()) {
			trace("loadTree - Obj " + obj);
			trace("loadTree - Obj name " + obj.name);
			trace("loadTree - paramsDict[obj] = " + paramsDict[obj]);
			trace("loadTree - field(obj) = " + Reflect.field(obj, "__name"));
			trace("loadTree - hasField(obj) = " + Reflect.hasField(obj, "__name"));
			trace("loadTree - fields(obj) = " + Reflect.fields(obj));
			trace("loadTree - getProperty(obj) = " + Reflect.getProperty(obj, "__name"));
		}*/

		var container:DisplayObjectContainer = null;

		if (Std.isOfType(obj, DisplayObjectContainer))
			container = cast obj;

		if (container != null) {
			trace("this is a container");
			if (data.children) {
				trace("has data.children");
				for (item in cast(data.children, Array<Dynamic>)) {
					if (!_forEditor && item.customParams && item.customParams.forEditor)
						continue;
					trace("container.addChild for item = " + item);
					container.addChild(loadTree(item, factory, paramsDict));
				}
			}

			if (isExternalSource(data)) {
				trace("isExternal");
				var externalData:Dynamic = _dataFormatter.read(_assetMediator.getExternalData(data.customParams.source));
				// container.addChild(create(externalData));
				// paramsDict[obj] = data;
				var res:Dynamic = load(externalData);
				container.addChild(cast(res.object, DisplayObject));
				paramsDict[obj] = data;
				data.externalParams = res.params;
			}
		}

		if (_displayObjectHandler != null)
			_displayObjectHandler.onCreate(obj, paramsDict);

		return obj;
	}

	/**
	 *  Helper function to bind UI elements to properties.
	 *  It loops through all the UI elements, if the name starts with "_", then bind to the object property with the same name.
	 *
	 *  <p>NOTE: This function will ONLY work if your object._xxx is public variable.</p>
	 *
	 * @param view object you want to bind to
	 * @param paramsDict params dictionary of meta data
	 */
	public static function bind(view:Dynamic, paramsDict:Map<DisplayObject, Dynamic>):Void {
		for (obj in paramsDict.keys()) {
			/*trace("bind - Obj " + obj);
				trace("bind - Obj name " + obj.name);
				trace("Type.getInstanceFields = " + Type.getInstanceFields(Type.getClass(obj)));
				 trace("bind - paramsDict[obj] = " + paramsDict[obj]);
					trace("bind - field(obj) = " + Reflect.field(obj, "__name"));
					trace("bind - hasField(obj) = " + Reflect.hasField(obj, "__name"));
					trace("bind - fields(obj) = " + Reflect.fields(obj));
					trace("bind - getProperty(obj) = " + Reflect.getProperty(obj, "__name")); */
			var name:String = null;

			if (Reflect.hasField(obj, "__name")) {
				name = Reflect.getProperty(obj, "__name");
				if (name != null && name.charAt(0) == "_") {
					if (Type.getInstanceFields(Type.getClass(view)).contains(name)) {
						Reflect.setProperty(view, name, obj);
						if (Std.isOfType(obj, ICustomClass)) {
							cast(obj, ICustomClass).init();
						}
					} else
						throw new Error("Property " + name + " not defined in " + Lib.getQualifiedClassName(view));
				}
			}
		}
	}

	/**
	 * @private
	 */
	private function isExternalSource(param:Dynamic):Bool {
		if (param && param.customParams && param.customParams.source) {
			return true;
		} else {
			return false;
		}
	}

	private static var RESOURCE_CLASSES:Array<String> = [
		"XML",
		"Object",
		"feathers.data.ListCollection",
		"feathers.data.HierarchicalCollection"
	];

	private function roundToDigit(value:Float, digit:Int = 2):Float {
		var a:Float = Math.pow(10, digit);
		return Math.round(value * a) / a;
	}

	private static function doTrimLeadingSpace(container:DisplayObjectContainer):Void {
		var minX:Float = Math.POSITIVE_INFINITY;
		var minY:Float = Math.POSITIVE_INFINITY;

		var i:Int;
		var obj:DisplayObject;

		var num:Int = container.numChildren;
		for (i in 0...num) {
			obj = container.getChildAt(i);

			var rect:Rectangle = obj.getBounds(container);

			if (rect.x < minX) {
				minX = rect.x;
			}

			if (rect.y < minY) {
				minY = rect.y;
			}
		}

		num = container.numChildren;
		for (i in 0...num) {
			obj = container.getChildAt(i);
			obj.x -= minX;
			obj.y -= minY;
		}
	}

	/**
	 * @private
	 */
	public static function cloneObject(object:Dynamic):Dynamic {
		return Json.parse(Json.stringify(object));
	}

	/**
	 * @inheritDoc
	 */
	public function createUIElement(data:Dynamic):Dynamic {
		return {object: _factory.create(data), params: data};
	}

	/**
	 * @private
	 */
	public function get_dataFormatter():IDataFormatter {
		return _dataFormatter;
	}

	/**
	 * @private
	 */
	public function set_dataFormatter(value:IDataFormatter):Void {
		_dataFormatter = value;
	}

	/**
	 * @copy IUIBuilder#create()
	 * @see #load()
	 */
	public function create(data:Dynamic, trimLeadingSpace:Bool = true, binder:Dynamic = null):Dynamic {
		trace("create");
		return load(data, trimLeadingSpace, binder).object;
	}

	/**
	 * @inheritDoc
	 */
	public function localizeTexts(root:DisplayObject, paramsDict:Map<DisplayObject, Dynamic>):Void {
		if (_localization != null && _localization.locale != null) {
			localizeTree(root, paramsDict);
		}
	}

	private function localizeTree(object:DisplayObject, paramsDict:Map<DisplayObject, Dynamic>):Void {
		var params:Dynamic = paramsDict[object];

		if (params && params.customParams && params.customParams.localizeKey) {
			var text:String = _localization.getLocalizedText(params.customParams.localizeKey);
			if (text == null)
				text = params.customParams.localizeKey;

			try {
				Reflect.setProperty(object, "text", text);
			} catch (e:Error) {}

			try {
				Reflect.setProperty(object, "label", text);
			} catch (e:Error) {}

			if (_localizationHandler != null)
				_localizationHandler.localize(object, text, paramsDict, _localization.locale);
		}

		var container:DisplayObjectContainer = null;

		if (Std.isOfType(object, DisplayObjectContainer))
			container = cast object;

		if (container != null) {
			var num:Int = container.numChildren;
			var i:Int;
			for (i in 0...num) {
				localizeTree(container.getChildAt(i), paramsDict);
			}
		}
	}

	/**
	 * @inheritDoc
	 */
	public function get_tweenBuilder():ITweenBuilder {
		return _tweenBuilder;
	}

	/**
	 * @private
	 */
	public function set_tweenBuilder(value:ITweenBuilder):ITweenBuilder {
		_tweenBuilder = value;
		return value;
	}

	/**
	 * @inheritDoc
	 */
	public function get_localization():ILocalization {
		return _localization;
	}

	/**
	 * @private
	 */
	public function set_localization(value:ILocalization):ILocalization {
		_localization = value;
		return value;
	}

	/**
	 * @inheritDoc
	 */
	public function get_localizationHandler():ILocalizationHandler {
		return _localizationHandler;
	}

	/**
	 * @private
	 */
	public function set_localizationHandler(value:ILocalizationHandler):ILocalizationHandler {
		_localizationHandler = value;
		return value;
	}

	/**
	 * @inheritDoc
	 */
	public function get_displayObjectHandler():IDisplayObjectHandler {
		return _displayObjectHandler;
	}

	/**
	 * @private
	 */
	public function set_displayObjectHandler(value:IDisplayObjectHandler):IDisplayObjectHandler {
		_displayObjectHandler = value;
		return value;
	}

	public var tweenBuilder(get, set):ITweenBuilder;

	/**
	 * Localization property
	 */
	public var localization(get, set):ILocalization;

	/**
	 * Localization handler
	 */
	public var localizationHandler(get, set):ILocalizationHandler;

	/**
	 * Display object handler
	 */
	public var displayObjectHandler(get, set):IDisplayObjectHandler;

	/**
	 *  Helper function to find ui element
	 * @param container root display object container you want to find
	 * @param property path separated by dots (e.g. bottom_container.layout.button1)
	 * @return
	 */
	public static function find(container:DisplayObjectContainer, path:String):DisplayObject {
		var array:Array<String> = path.split(".");

		var obj:DisplayObject = null;

		for (name in array) {
			if (container == null)
				return null;

			obj = container.getChildByName(name);
			container = cast(obj, DisplayObjectContainer);
		}

		return obj;
	}

	/***
	 * Helper function to find elements by tag
	 * @param tag name of the tag
	 * @param paramsDict params dictionary of meta data
	 * @return array of objects with the tag, if not found then return empty array
	 */
	public static function findByTag(tag:String, paramsDict:Map<Dynamic, Dynamic>):Array<Dynamic> {
		var result:Array<Dynamic> = [];

		for (obj in paramsDict) {
			var param:Dynamic = paramsDict[obj];
			if (param && param.customParams && param.customParams.tag == tag) {
				result.push(obj);
			}
		}

		return result;
	}
}
