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
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		Assets.libraryPaths["default"] = rootPath + "manifest/default.json";
		

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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_test_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_xml extends null { }
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


@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/SourceSansPro-Regular.ttf"; name = "Source Sans Pro"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/SourceSansPro-Semibold.ttf"; name = "Source Sans Pro Semibold"; super (); }}


#else

@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Regular.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Source Sans Pro"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Semibold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Source Sans Pro Semibold"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf extends openfl.text.Font { public function new () { name = "Source Sans Pro"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf extends openfl.text.Font { public function new () { name = "Source Sans Pro Semibold"; super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/SourceSansPro-Regular.ttf"; name = "Source Sans Pro"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/fonts/SourceSansPro-Semibold.ttf"; name = "Source Sans Pro Semibold"; super (); }}

#end

#end
#end

#end

#end