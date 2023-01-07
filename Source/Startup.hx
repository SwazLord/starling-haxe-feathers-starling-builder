package;

import openfl.display.StageScaleMode;
import starlingbuilder.engine.util.StageUtil;
import openfl.display3D.Context3DRenderMode;
import starling.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.events.ResizeEvent;
import openfl.display.Sprite;
import starling.core.Starling;

class Startup extends Sprite {
	private var starling:Starling;

	public var stageUtil:StageUtil;

	public function new() {
		super();
		//stage.scaleMode = StageScaleMode.NO_SCALE;
		stageUtil = new StageUtil(stage);
		starling = new Starling(Game, stage, null, null, Context3DRenderMode.AUTO, "auto");
		starling.showStats = true;
		starling.skipUnchangedFrames = true;
		starling.supportBrowserZoom = true;
		starling.supportHighResolutions = false;
		starling.stage.addEventListener(ResizeEvent.RESIZE, onResize);
		starling.addEventListener(Event.ROOT_CREATED, function():Void {
			// stage.scaleMode = StageScaleMode.NO_BORDER;
			startGame();
		});
		var w:Int = stage.stageWidth;
		var h:Int = stage.stageHeight;
		starling.viewPort = new Rectangle(0, 0, w, h);
		var size:Point = stageUtil.getScaledStageSize(w, h);

		starling.stage.stageWidth = cast size.x;
		starling.stage.stageHeight = cast size.y;
		starling.start();
	}

	private function startGame():Void {
		var game:Game = cast(starling.root, Game);
		game.start();
	}

	private function onResize(event:ResizeEvent):Void {
		starling.viewPort = new Rectangle(0, 0, event.width, event.height);

		var size:Point = stageUtil.getScaledStageSize(event.width, event.height);

		starling.stage.stageWidth = cast size.x;
		starling.stage.stageHeight = cast size.y;
	}
}
