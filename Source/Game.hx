package;

// import feathers.themes.MetalWorksDesktopTheme;
import feathers.layout.AnchorLayout;
import feathers.controls.LayoutGroup;
import starlingbuilder.engine.UIBuilder;
import starlingbuilder.engine.IUIBuilder;
import starlingbuilder.engine.LayoutLoader;
import starlingbuilder.demo.AssetMediator;
import starling.display.DisplayObject;
import starling.events.ResizeEvent;
import starling.core.Starling;
import starling.display.Image;
import openfl.Assets;
import starling.utils.AssetManager;
import starling.display.Sprite;
import starling.display.Button;

class Game extends Sprite {
	public static var assetManager:AssetManager;

	private var _assetMediator:AssetMediator;
	private var _sprite:Sprite;

	public static var uiBuilder:IUIBuilder;
	public static var linkers:Array<Dynamic> = [Button, LayoutGroup, AnchorLayout, feathers.controls.Button];

	public function new() {
		super();
	}

	public function start():Void {
		// new MetalWorksDesktopTheme();
		assetManager = new AssetManager();
		_assetMediator = new AssetMediator(assetManager);
		uiBuilder = new UIBuilder(_assetMediator);
		var loader:LayoutLoader = new LayoutLoader(ParsedLayouts);
		assetManager.enqueue([
			Assets.getPath("assets/textures/atlas.png"),
			Assets.getPath("assets/textures/atlas.xml")
		]);
		assetManager.loadQueue(function(ratio:Float):Void {
			trace(ratio);
			if (ratio == 1) {
				trace("Assets Loaded");
				_sprite = new Sprite();
				_sprite = cast uiBuilder.create(ParsedLayouts.game_ui, false, this);
				// _sprite.addChild(new Image(assetManager.getTexture("header_text")));
				addChild(_sprite);
				onResize(null);
			}
		});

		Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
	}

	private function onResize(event:ResizeEvent):Void {
		center(_sprite);
	}

	private function center(obj:DisplayObject):Void {
		obj.x = (Starling.current.stage.stageWidth - obj.width) * 0.5;
		obj.y = (Starling.current.stage.stageHeight - obj.height) * 0.5;
	}
}
