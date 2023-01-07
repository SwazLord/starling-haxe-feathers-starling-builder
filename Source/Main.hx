package;

import starlingbuilder.engine.util.StageUtil;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.events.ResizeEvent;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.StageScaleMode;
import openfl.display3D.Context3DRenderMode;
import openfl.system.Capabilities;
import starling.core.Starling;
import starling.events.Event;

/**
 * ...
 * @author Matse
 */
class Main extends Sprite {
	private var _starling:Starling;

	public var stageUtil:StageUtil;

	public function new() {
		super();

		if (stage != null)
			start();
		else
			addEventListener(openfl.events.Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Dynamic):Void {
		removeEventListener(openfl.events.Event.ADDED_TO_STAGE, onAddedToStage);

		stage.scaleMode = StageScaleMode.NO_SCALE;

		start();
	}

	private function start():Void {
		_starling = new Starling(Game, stage, null, null, Context3DRenderMode.AUTO, "auto");
		_starling.enableErrorChecking = Capabilities.isDebugger;
		_starling.showStats = false;
		_starling.skipUnchangedFrames = true;
		_starling.supportBrowserZoom = true;
		// _starling.supportHighResolutions = true;
		_starling.simulateMultitouch = true;
		_starling.addEventListener(Event.ROOT_CREATED, function():Void {
			// loadAssets(startGame);
			trace("root created");
			startGame();
		});

		// this.stage.addEventListener(Event.RESIZE, onResize, false, Max.INT_MAX_VALUE, true);

		_starling.start();
	}

	private function startGame():Void {
		var game:Game = cast(_starling.root, Game);
		game.start();
	}
}
