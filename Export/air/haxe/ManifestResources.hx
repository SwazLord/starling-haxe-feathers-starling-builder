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

		data = '{"name":null,"assets":"aoy4:sizei1211810y4:typey5:IMAGEy9:classNamey34:__ASSET__assets_textures_atlas_pngy2:idy29:assets%2Ftextures%2Fatlas.pnggoR0i2716R1y4:TEXTR3y34:__ASSET__assets_textures_atlas_xmlR5y29:assets%2Ftextures%2Fatlas.xmlgoR0i20725R1R7R3y50:__ASSET__assets_textures_bitmapfont_arialround_fntR5y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.fntgoR0i32050R1R2R3y50:__ASSET__assets_textures_bitmapfont_arialround_pngR5y47:assets%2Ftextures%2Fbitmapfont%2FArialRound.pnggoR0i13287R1R7R3y39:__ASSET__assets_textures_bradybunch_fntR5y34:assets%2Ftextures%2Fbradybunch.fntgoR0i766539R1R2R3y39:__ASSET__assets_textures_bradybunch_pngR5y34:assets%2Ftextures%2Fbradybunch.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:keep @:image("Assets/textures/atlas.png") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_png extends lime.graphics.Image {}
@:keep @:file("Assets/textures/atlas.xml") @:noCompletion #if display private #end class __ASSET__assets_textures_atlas_xml extends haxe.io.Bytes {}
@:keep @:file("Assets/textures/bitmapfont/ArialRound.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bitmapfont/ArialRound.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bitmapfont_arialround_png extends lime.graphics.Image {}
@:keep @:file("Assets/textures/bradybunch.fnt") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_fnt extends haxe.io.Bytes {}
@:keep @:image("Assets/textures/bradybunch.png") @:noCompletion #if display private #end class __ASSET__assets_textures_bradybunch_png extends lime.graphics.Image {}
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