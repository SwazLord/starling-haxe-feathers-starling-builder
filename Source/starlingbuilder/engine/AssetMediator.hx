package starlingbuilder.engine;

import starling.assets.AssetManager;
import openfl.Assets;
import starlingbuilder.engine.DefaultAssetMediator;

class AssetMediator extends DefaultAssetMediator {
	public function new(assetManager:AssetManager) {
		super(assetManager);
	}

	override public function getExternalData(name:String):Dynamic {
		return Assets.getText("assets/layouts/" + name + ".json");
	}
}
