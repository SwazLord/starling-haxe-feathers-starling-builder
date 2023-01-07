package;

import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy29:assets%2Ftextures%2Fatlas.pngy4:sizei1211810y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y29:assets%2Ftextures%2Fatlas.xmlR2i2716R3y4:TEXTR5R7R6tgoR0y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.fntR2i20725R3R8R5R9R6tgoR0y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.pngR2i32050R3R4R5R10R6tgoR0y34:assets%2Ftextures%2Fbradybunch.fntR2i13287R3R8R5R11R6tgoR0y34:assets%2Ftextures%2Fbradybunch.pngR2i766539R3R4R5R12R6tgoR0y31:assets%2Flayouts%2Fgame_ui.jsonR2i7457R3R8R5R13R6tgoR0y36:assets%2Flayouts%2Fgame_ui_test.jsonR2i19060R3R8R5R14R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_test_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("Assets/textures/atlas.png") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends lime.graphics.Image {}
@:keep @:file("Assets/textures/atlas.xml") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends haxe.io.Bytes {}
@:keep @:file("Assets/textures/bitmapfont/ArialRound.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bitmapfont/ArialRound.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends lime.graphics.Image {}
@:keep @:file("Assets/textures/bradybunch.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bradybunch.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends lime.graphics.Image {}
@:keep @:file("Assets/layouts/game_ui.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_json extends haxe.io.Bytes {}
@:keep @:file("Assets/layouts/game_ui_test.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_test_json extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end

#end