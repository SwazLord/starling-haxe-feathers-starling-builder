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

		data = '{"name":null,"assets":"aoy4:sizei149508y4:typey4:FONTy9:classNamey47:__ASSET__assets_fonts_sourcesanspro_regular_ttfy2:idy42:assets%2Ffonts%2FSourceSansPro-Regular.ttfgoR0i149352R1R2R3y48:__ASSET__assets_fonts_sourcesanspro_semibold_ttfR5y43:assets%2Ffonts%2FSourceSansPro-Semibold.ttfgoR0i7773R1y4:TEXTR3y28:__ASSET__assets_game_ui_jsonR5y21:assets%2Fgame_ui.jsongoR0i19060R1R9R3y33:__ASSET__assets_game_ui_test_jsonR5y26:assets%2Fgame_ui_test.jsongoR0i85319R1y5:IMAGER3y42:__ASSET__assets_img_metalworks_desktop_pngR5y37:assets%2Fimg%2Fmetalworks_desktop.pnggoR0i13618R1R9R3y42:__ASSET__assets_img_metalworks_desktop_xmlR5y37:assets%2Fimg%2Fmetalworks_desktop.xmlgoR0i16432R1R9R3y33:__ASSET__assets_layouts_card_jsonR5y28:assets%2Flayouts%2Fcard.jsongoR0i4284R1R9R3y33:__ASSET__assets_layouts_game_jsonR5y28:assets%2Flayouts%2Fgame.jsongoR0i5183R1R9R3y36:__ASSET__assets_layouts_game_ui_jsonR5y31:assets%2Flayouts%2Fgame_ui.jsongoR0i3053R1R9R3y33:__ASSET__assets_layouts_menu_jsonR5y28:assets%2Flayouts%2Fmenu.jsongoR0i38273R1R9R3y45:__ASSET__assets_settings_editor_template_jsonR5y40:assets%2Fsettings%2Feditor_template.jsongoR0i2R1R9R3y34:__ASSET__assets_settings_libs_jsonR5y29:assets%2Fsettings%2Flibs.jsongoR0i693R1R9R3y41:__ASSET__assets_settings_recent_open_jsonR5y36:assets%2Fsettings%2Frecent_open.jsongoR0i58R1R9R3y45:__ASSET__assets_settings_texture_options_jsonR5y40:assets%2Fsettings%2Ftexture_options.jsongoR0i265R1R9R3y40:__ASSET__assets_settings_ui_builder_jsonR5y35:assets%2Fsettings%2Fui_builder.jsongoR0i142R1R9R3y47:__ASSET__assets_settings_workspace_setting_jsonR5y42:assets%2Fsettings%2Fworkspace_setting.jsongoR0i225831R1R14R3y34:__ASSET__assets_textures_atlas_pngR5y29:assets%2Ftextures%2Fatlas.pnggoR0i1303R1R9R3y34:__ASSET__assets_textures_atlas_xmlR5y29:assets%2Ftextures%2Fatlas.xmlgoR0i20725R1R9R3y50:__ASSET__assets_textures_bitmapfont_arialround_fntR5y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.fntgoR0i32050R1R14R3y50:__ASSET__assets_textures_bitmapfont_arialround_pngR5y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends flash.text.Font { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends flash.text.Font { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_game_ui_test_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_xml extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_card_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_game_ui_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_layouts_menu_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_editor_template_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_libs_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_recent_open_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_texture_options_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_ui_builder_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_settings_workspace_setting_json extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:keep @:font("Assets/fonts/SourceSansPro-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font {}
@:keep @:font("Assets/fonts/SourceSansPro-Semibold.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font {}
@:keep @:file("Assets/game_ui.json") @:noCompletion #if display private #end class __ASSET__assets_game_ui_json extends haxe.io.Bytes {}
@:keep @:file("Assets/game_ui_test.json") @:noCompletion #if display private #end class __ASSET__assets_game_ui_test_json extends haxe.io.Bytes {}
@:keep @:image("Assets/img/metalworks_desktop.png") @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_png extends lime.graphics.Image {}
@:keep @:file("Assets/img/metalworks_desktop.xml") @:noCompletion #if display private #end class __ASSET__assets_img_metalworks_desktop_xml extends haxe.io.Bytes {}
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

@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Regular.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Source Sans Pro"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Semibold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Source Sans Pro Semibold"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_sourcesanspro_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_sourcesanspro_semibold_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_sourcesanspro_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_sourcesanspro_semibold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_sourcesanspro_semibold_ttf ()); super (); }}

#end

#end
#end

#end

#end