package;

import starling.utils.MathUtil;
import feathers.layout.TiledRowsLayout;
import starling.animation.Juggler;
import starling.display.MovieClip;
import starlingbuilder.engine.AssetMediator;
import starling.assets.AssetManager;
import feathers.layout.VerticalLayout;
import feathers.layout.HorizontalLayout;
import feathers.controls.ScrollContainer;
import feathers.layout.AnchorLayout;
import feathers.controls.LayoutGroup;
import feathers.themes.MetalWorksDesktopTheme;
import starlingbuilder.engine.UIBuilder;
import starlingbuilder.engine.IUIBuilder;
import starlingbuilder.engine.LayoutLoader;
import starling.display.DisplayObject;
import starling.events.ResizeEvent;
import starling.core.Starling;
import starling.display.Image;
import openfl.Assets;
import starling.display.Sprite;
import starling.display.Button;

@:keep
class Game extends Sprite {
	public static var assetManager:AssetManager;

	private var _assetMediator:AssetMediator;
	private var _sprite:Sprite;

	public var _scrollContainer:ScrollContainer = null;
	public var _play_btn:Button = null;
	public var _bird_mc:MovieClip;

	public static var uiBuilder:IUIBuilder;
	public static var linkers:Array<Dynamic> = [
		Button,
		LayoutGroup,
		AnchorLayout,
		ScrollContainer,
		HorizontalLayout,
		VerticalLayout,
		TiledRowsLayout
	];

	public function new() {
		super();
		//var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
	}

	public function start():Void {
		// new MetalWorksDesktopTheme();
		assetManager = new AssetManager();
		assetManager.verbose = true;
		_assetMediator = new AssetMediator(assetManager);
		uiBuilder = new UIBuilder(_assetMediator);
		var loader:LayoutLoader = new LayoutLoader(ParsedLayouts);
		assetManager.enqueue([
			Assets.getPath("assets/textures/atlas.png"),
			Assets.getPath("assets/textures/atlas.xml")
		]);
		assetManager.loadQueue(onComplete, onError, onProgress);

		Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
	}

	function onComplete():Void {
		trace("Assets Loaded");
		_sprite = new Sprite();
		_sprite = cast uiBuilder.create(ParsedLayouts.game_ui, false, this);
		 _sprite.addChild(new Image(assetManager.getTexture("contact_button")));
		/* trace("stage.stageHeight = " + stage.stageHeight + " stage.stageWidth " + stage.stageWidth);
			var new_scale:Float = MathUtil.min(1.0 * stage.stageWidth / _sprite.width, 1.0 * stage.stageHeight / _sprite.height);
			_sprite.scaleX = _sprite.scaleY = round2(new_scale, 2);
			trace("_sprite.scaleX = " + _sprite.scaleX);
			_sprite.width = stage.stageWidth;
			_sprite.height = stage.stageHeight; */
		addChild(_sprite);
		onResize(null);
		init();
	}

	function onError(msg:String):Void {
		trace(msg);
	}

	function onProgress(ratio:Float):Void {
		trace(ratio);
	}

	function init() {
		/* var item_1:Image = new Image(assetManager.getTexture("cell_01"));
			var item_2:Image = new Image(assetManager.getTexture("cell_02"));
			var item_3:Image = new Image(assetManager.getTexture("cell_03"));
			var item_4:Image = new Image(assetManager.getTexture("cell_04"));
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 10;

			_scrollContainer = new ScrollContainer();
			_scrollContainer.width = 300;
			_scrollContainer.layout = layout;

			_scrollContainer.addChild(item_1);
			_scrollContainer.addChild(item_2);
			_scrollContainer.addChild(item_3);
			_scrollContainer.addChild(item_4);
			_sprite.addChild(_scrollContainer);

			_scrollContainer.snapToPages = true; */

		// _play_btn.enabled = false;

		// _bird_mc.play();
		// Starling.currentJuggler.add(_bird_mc);
	}

	public static function round2(num:Float, decimals:Int):Float {
		var m:Int = Std.int(Math.pow(10, decimals));
		return Math.round(num * m) / m;
	}

	private function onResize(event:ResizeEvent):Void {
		center(_sprite);
	}

	private function center(obj:DisplayObject):Void {
		obj.x = (Starling.current.stage.stageWidth - obj.width) * 0.5;
		obj.y = (Starling.current.stage.stageHeight - obj.height) * 0.5;
	}
}
