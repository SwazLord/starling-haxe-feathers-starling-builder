/*
Copyright 2012-2021 Bowler Hat LLC. All Rights Reserved.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package feathers.themes
;
	import flash.display.Bitmap;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * The "Metal Works" theme for mobile Feathers apps.
	 *
	 * <p>This version of the theme embeds its assets. To load assets at
	 * runtime, see <code>MetalWorksMobileThemeWithAssetManager</code> instead.</p>
	 *
	 * @see http://feathersui.com/help/theme-assets.html
	 */
	 class MetalWorksMobileTheme extends BaseMetalWorksMobileTheme
	{
		/**
		 * @private
		 */
		@:file("/../assets/images/metalworks_mobile.xml")		static var ATLAS_XML:Class<Dynamic>;

		/**
		 * @private
		 */
		@:bitmap("/../assets/images/metalworks_mobile.png")		static var ATLAS_BITMAP:Class<Dynamic>;

		/**
		 * Constructor.
		 */
		public function new()
		{
			super();
			this.initialize();
		}

		/**
		 * @private
		 */
		override function initialize()
		{
			this.initializeTextureAtlas();
			super.initialize();
		}

		/**
		 * @private
		 */
		function initializeTextureAtlas()
		{
			var atlasBitmapData= cast(Type.createInstance(ATLAS_BITMAP, []), Bitmap).bitmapData;
			var atlasTexture= Texture.fromBitmapData(atlasBitmapData, false, false, 2);
			atlasTexture.root.onRestore = this.atlasTexture_onRestore;
			atlasBitmapData.dispose();
			this.atlas = new TextureAtlas(atlasTexture, new compat.XML(Type.createInstance(ATLAS_XML, [])));
		}

		/**
		 * @private
		 */
		function atlasTexture_onRestore()
		{
			var atlasBitmapData= cast(Type.createInstance(ATLAS_BITMAP, []), Bitmap).bitmapData;
			this.atlas.texture.root.uploadBitmapData(atlasBitmapData);
			atlasBitmapData.dispose();
		}
	}

