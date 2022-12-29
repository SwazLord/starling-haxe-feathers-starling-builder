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

		data = '{"name":null,"assets":"aoy4:pathy21:assets%2Fgame_ui.jsony4:sizei1769y4:typey4:TEXTy2:idR1y7:preloadtgoR0y25:assets%2Fgame_ui_old.jsonR2i872R3R4R5R7R6tgoR0y28:assets%2Flayouts%2Fcard.jsonR2i16432R3R4R5R8R6tgoR0y28:assets%2Flayouts%2Fgame.jsonR2i4284R3R4R5R9R6tgoR0y31:assets%2Flayouts%2Fgame_ui.jsonR2i5183R3R4R5R10R6tgoR0y28:assets%2Flayouts%2Fmenu.jsonR2i3053R3R4R5R11R6tgoR0y40:assets%2Fsettings%2Feditor_template.jsonR2i38273R3R4R5R12R6tgoR0y29:assets%2Fsettings%2Flibs.jsonR2i2R3R4R5R13R6tgoR0y36:assets%2Fsettings%2Frecent_open.jsonR2i693R3R4R5R14R6tgoR0y40:assets%2Fsettings%2Ftexture_options.jsonR2i58R3R4R5R15R6tgoR0y35:assets%2Fsettings%2Fui_builder.jsonR2i265R3R4R5R16R6tgoR0y42:assets%2Fsettings%2Fworkspace_setting.jsonR2i142R3R4R5R17R6tgoR0y29:assets%2Ftextures%2Fatlas.pngR2i225831R3y5:IMAGER5R18R6tgoR0y29:assets%2Ftextures%2Fatlas.xmlR2i1303R3R4R5R20R6tgoR0y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.fntR2i20725R3R4R5R21R6tgoR0y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.pngR2i32050R3R19R5R22R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_old_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_card_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_menu_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_editor_template_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_libs_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_recent_open_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_texture_options_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_ui_builder_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_workspace_setting_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("Assets/game_ui.json") @:noCompletion #if display private #end class __ASSET__assets_game_ui_json extends haxe.io.Bytes {}
@:keep @:file("Assets/game_ui_old.json") @:noCompletion #if display private #end class __ASSET__assets_game_ui_old_json extends haxe.io.Bytes {}
@:keep @:file("Assets/layouts/card.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_card_json extends haxe.io.Bytes {}
@:keep @:file("Assets/layouts/game.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_game_json extends haxe.io.Bytes {}
@:keep @:file("Assets/layouts/game_ui.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_json extends haxe.io.Bytes {}
@:keep @:file("Assets/layouts/menu.json") @:noCompletion #if display private #end class __ASSET__assets_layouts_menu_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/editor_template.json") @:noCompletion #if display private #end class __ASSET__assets_settings_editor_template_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/libs.json") @:noCompletion #if display private #end class __ASSET__assets_settings_libs_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/recent_open.json") @:noCompletion #if display private #end class __ASSET__assets_settings_recent_open_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/texture_options.json") @:noCompletion #if display private #end class __ASSET__assets_settings_texture_options_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/ui_builder.json") @:noCompletion #if display private #end class __ASSET__assets_settings_ui_builder_json extends haxe.io.Bytes {}
@:keep @:file("Assets/settings/workspace_setting.json") @:noCompletion #if display private #end class __ASSET__assets_settings_workspace_setting_json extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/atlas.png") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends lime.graphics.Image {}
@:keep @:file("Assets/textures/atlas.xml") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends haxe.io.Bytes {}
@:keep @:file("Assets/textures/bitmapfont/ArialRound.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bitmapfont/ArialRound.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends lime.graphics.Image {}
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