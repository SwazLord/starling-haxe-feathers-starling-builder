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

		data = '{"name":null,"assets":"aoy4:sizei149508y4:typey4:FONTy9:classNamey47:__ASSET__assets_fonts_sourcesanspro_regular_ttfy2:idy42:assets%2Ffonts%2FSourceSansPro-Regular.ttfy7:preloadtgoR0i149352R1R2R3y48:__ASSET__assets_fonts_sourcesanspro_semibold_ttfR5y43:assets%2Ffonts%2FSourceSansPro-Semibold.ttfR7tgoy4:pathy21:assets%2Fgame_ui.jsonR0i3288R1y4:TEXTR5R11R7tgoR10y26:assets%2Fgame_ui_test.jsonR0i19060R1R12R5R13R7tgoR10y37:assets%2Fimg%2Fmetalworks_desktop.pngR0i85319R1y5:IMAGER5R14R7tgoR10y37:assets%2Fimg%2Fmetalworks_desktop.xmlR0i13618R1R12R5R16R7tgoR10y28:assets%2Flayouts%2Fcard.jsonR0i16432R1R12R5R17R7tgoR10y28:assets%2Flayouts%2Fgame.jsonR0i4284R1R12R5R18R7tgoR10y31:assets%2Flayouts%2Fgame_ui.jsonR0i5183R1R12R5R19R7tgoR10y28:assets%2Flayouts%2Fmenu.jsonR0i3053R1R12R5R20R7tgoR10y40:assets%2Fsettings%2Feditor_template.jsonR0i38273R1R12R5R21R7tgoR10y29:assets%2Fsettings%2Flibs.jsonR0i2R1R12R5R22R7tgoR10y36:assets%2Fsettings%2Frecent_open.jsonR0i786R1R12R5R23R7tgoR10y40:assets%2Fsettings%2Ftexture_options.jsonR0i58R1R12R5R24R7tgoR10y35:assets%2Fsettings%2Fui_builder.jsonR0i265R1R12R5R25R7tgoR10y42:assets%2Fsettings%2Fworkspace_setting.jsonR0i142R1R12R5R26R7tgoR10y29:assets%2Ftextures%2Fatlas.pngR0i223173R1R15R5R27R7tgoR10y29:assets%2Ftextures%2Fatlas.xmlR0i2121R1R12R5R28R7tgoR10y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.fntR0i20725R1R12R5R29R7tgoR10y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.pngR0i32050R1R15R5R30R7tgoR10y34:assets%2Ftextures%2Fbradybunch.fntR0i13287R1R12R5R31R7tgoR10y34:assets%2Ftextures%2Fbradybunch.pngR0i766539R1R15R5R32R7tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:font("Export/html5/obj/webfont/SourceSansPro-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font {}
@:keep @:font("Export/html5/obj/webfont/SourceSansPro-Semibold.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font {}
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
@:keep @:file("Assets/textures/bradybunch.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bradybunch.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Regular"; #else ascender = 984; descender = -273; height = 1257; numGlyphs = 1114; underlinePosition = -100; underlineThickness = 50; unitsPerEM = 1000; #end name = "Source Sans Pro"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_sourcesanspro_semibold_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_sourcesanspro_semibold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/SourceSansPro-Semibold"; #else ascender = 984; descender = -273; height = 1257; numGlyphs = 1114; underlinePosition = -100; underlineThickness = 50; unitsPerEM = 1000; #end name = "Source Sans Pro Semibold"; super (); }}


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