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

package feathers.themes;

import feathers.controls.Alert;
import feathers.controls.AutoComplete;
import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.ButtonState;
import feathers.controls.Callout;
import feathers.controls.Check;
import feathers.controls.DateTimeSpinner;
import feathers.controls.Drawers;
import feathers.controls.GroupedList;
import feathers.controls.Header;
import feathers.controls.ImageLoader;
import feathers.controls.ItemRendererLayoutOrder;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.NumericStepper;
import feathers.controls.PageIndicator;
import feathers.controls.Panel;
import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ProgressBar;
import feathers.controls.Radio;
import feathers.controls.ScrollContainer;
import feathers.controls.ScrollScreen;
import feathers.controls.ScrollText;
import feathers.controls.Scroller;
import feathers.controls.SimpleScrollBar;
import feathers.controls.Slider;
import feathers.controls.SpinnerList;
import feathers.controls.StepperButtonLayoutMode;
import feathers.controls.TabBar;
import feathers.controls.TextArea;
import feathers.controls.TextCallout;
import feathers.controls.TextInput;
import feathers.controls.TextInputState;
import feathers.controls.ToggleButton;
import feathers.controls.ToggleSwitch;
import feathers.controls.TrackLayoutMode;
import feathers.controls.Tree;
import feathers.controls.popups.BottomDrawerPopUpContentManager;
import feathers.controls.popups.CalloutPopUpContentManager;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.DefaultTreeItemRenderer;
import feathers.controls.text.ITextEditorViewPort;
import feathers.controls.text.StageTextTextEditor;
import feathers.controls.text.TextBlockTextEditor;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.controls.text.TextFieldTextEditorViewPort;
import feathers.core.FeathersControl;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;
import feathers.layout.Direction;
import feathers.layout.HorizontalAlign;
import feathers.layout.HorizontalLayout;
import feathers.layout.RelativePosition;
import feathers.layout.VerticalAlign;
import feathers.layout.VerticalLayout;
import feathers.media.FullScreenToggleButton;
import feathers.media.MuteToggleButton;
import feathers.media.PlayPauseToggleButton;
import feathers.media.SeekSlider;
import feathers.media.VolumeSlider;
import feathers.skins.ImageSkin;
import feathers.system.DeviceCapabilities;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.text.TextFormat;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import feathers.core.FocusManager;
import feathers.controls.DataGrid;
import feathers.controls.renderers.DefaultDataGridHeaderRenderer;
import feathers.controls.renderers.DefaultDataGridCellRenderer;
import feathers.controls.Toast;
import feathers.controls.AutoSizeMode;
import starling.display.DisplayObjectContainer;

/**
 * The base class for the "Metal Works" theme for mobile Feathers apps.
 * Handles everything except asset loading, which is left to subclasses.
 *
 * @see MetalWorksMobileTheme
 * @see MetalWorksMobileThemeWithAssetManager
 */
class BaseMetalWorksMobileTheme extends StyleNameFunctionTheme {
	@:font("/../assets/fonts/SourceSansPro-Regular.ttf") static var SOURCE_SANS_PRO_REGULAR:Class<Dynamic>;

	@:font("/../assets/fonts/SourceSansPro-Semibold.ttf") static var SOURCE_SANS_PRO_SEMIBOLD:Class<Dynamic>;

	/**
	 * The name of the embedded font used by controls in this theme. Comes
	 * in normal and bold weights.
	 */
	public static inline final FONT_NAME = "SourceSansPro";

	/**
	 * The stack of fonts to use for controls that don't use embedded fonts.
	 */
	public static inline final FONT_NAME_STACK = "Source Sans Pro,Helvetica,_sans";

	static inline final PRIMARY_BACKGROUND_COLOR:UInt = 0x4a4137;
	static inline final LIGHT_TEXT_COLOR:UInt = 0xe5e5e5;
	static inline final DARK_TEXT_COLOR:UInt = 0x1a1816;
	static inline final SELECTED_TEXT_COLOR:UInt = 0xff9900;
	static inline final LIGHT_DISABLED_TEXT_COLOR:UInt = 0x8a8a8a;
	static inline final DARK_DISABLED_TEXT_COLOR:UInt = 0x383430;
	static inline final LIST_BACKGROUND_COLOR:UInt = 0x383430;
	static inline final GROUPED_LIST_HEADER_BACKGROUND_COLOR:UInt = 0x2e2a26;
	static inline final GROUPED_LIST_FOOTER_BACKGROUND_COLOR:UInt = 0x2e2a26;
	static inline final MODAL_OVERLAY_COLOR:UInt = 0x29241e;
	static inline final MODAL_OVERLAY_ALPHA:Float = 0.8;
	static inline final DRAWER_OVERLAY_COLOR:UInt = 0x29241e;
	static inline final DRAWER_OVERLAY_ALPHA:Float = 0.4;
	static inline final VIDEO_OVERLAY_COLOR:UInt = 0x1a1816;
	static inline final VIDEO_OVERLAY_ALPHA:Float = 0.2;
	static inline final DATA_GRID_COLUMN_OVERLAY_COLOR:UInt = 0x383430;
	static inline final DATA_GRID_COLUMN_OVERLAY_ALPHA:Float = 0.4;

	static final DEFAULT_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 1);
	static final BUTTON_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 20);
	static final SMALL_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 1);
	static final BACK_BUTTON_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 1, 28);
	static final FORWARD_BUTTON_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 1, 28);
	static final ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(1, 1, 1, 42);
	static final INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 40);
	static final INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(7, 7, 1, 35);
	static final INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(7, 2, 1, 35);
	static final INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(7, 7, 1, 30);
	static final TAB_SCALE9_GRID:Rectangle = new Rectangle(11, 11, 1, 22);
	static final SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(2, 6, 1, 32);
	static final HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(4, 0, 4, 5);
	static final VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(0, 4, 5, 4);
	static final FOCUS_INDICATOR_SCALE_9_GRID:Rectangle = new Rectangle(5, 5, 1, 1);
	static final DATA_GRID_HEADER_DIVIDER_SCALE_9_GRID:Rectangle = new Rectangle(0, 1, 2, 4);
	static final DATA_GRID_VERTICAL_DIVIDER_SCALE_9_GRID:Rectangle = new Rectangle(0, 1, 1, 4);
	static final DATA_GRID_COLUMN_RESIZE_SCALE_9_GRID:Rectangle = new Rectangle(0, 1, 3, 28);
	static final DATA_GRID_COLUMN_DROP_INDICATOR_SCALE_9_GRID:Rectangle = new Rectangle(0, 1, 3, 28);

	static final HEADER_SKIN_TEXTURE_REGION:Rectangle = new Rectangle(1, 1, 128, 64);
	static final TAB_SKIN_TEXTURE_REGION:Rectangle = new Rectangle(1, 0, 22, 44);

	/**
	 * @private
	 * The theme's custom style name for item renderers in a SpinnerList.
	 */
	static inline final THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER = "metal-works-mobile-spinner-list-item-renderer";

	/**
	 * @private
	 * The theme's custom style name for item renderers in a PickerList.
	 */
	static inline final THEME_STYLE_NAME_TABLET_PICKER_LIST_ITEM_RENDERER = "metal-works-mobile-tablet-picker-list-item-renderer";

	/**
	 * @private
	 * The theme's custom style name for buttons in an Alert's button group.
	 */
	static inline final THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON = "metal-works-mobile-alert-button-group-button";

	/**
	 * @private
	 * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
	 */
	static inline final THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB = "metal-works-mobile-horizontal-simple-scroll-bar-thumb";

	/**
	 * @private
	 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
	 */
	static inline final THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB = "metal-works-mobile-vertical-simple-scroll-bar-thumb";

	/**
	 * @private
	 * The theme's custom style name for the minimum track of a horizontal slider.
	 */
	static inline final THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK = "metal-works-mobile-horizontal-slider-minimum-track";

	/**
	 * @private
	 * The theme's custom style name for the maximum track of a horizontal slider.
	 */
	static inline final THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK = "metal-works-mobile-horizontal-slider-maximum-track";

	/**
	 * @private
	 * The theme's custom style name for the minimum track of a vertical slider.
	 */
	static inline final THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK = "metal-works-mobile-vertical-slider-minimum-track";

	/**
	 * @private
	 * The theme's custom style name for the maximum track of a vertical slider.
	 */
	static inline final THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK = "metal-works-mobile-vertical-slider-maximum-track";

	/**
	 * @private
	 * The theme's custom style name for the item renderer of the DateTimeSpinner's SpinnerLists.
	 */
	static inline final THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER = "metal-works-mobile-date-time-spinner-list-item-renderer";

	/**
	 * @private
	 * The theme's custom style name for the action buttons of a toast.
	 */
	static inline final THEME_STYLE_NAME_TOAST_ACTIONS_BUTTON = "metal-works-mobile-toast-actions-button";

	/**
	 * The default global text renderer factory for this theme creates a
	 * TextBlockTextRenderer.
	 */
	static function textRendererFactory():ITextRenderer {
		return new TextBlockTextRenderer();
	}

	/**
	 * The default global text editor factory for this theme creates a
	 * StageTextTextEditor.
	 */
	static function textEditorFactory():ITextEditor {
		return new StageTextTextEditor();
	}

	/**
	 * The text editor factory for a TextArea creates a
	 * TextFieldTextEditorViewPort.
	 */
	static function textAreaTextEditorFactory():ITextEditorViewPort {
		return new TextFieldTextEditorViewPort();
	}

	/**
	 * The text editor factory for a NumericStepper creates a
	 * TextBlockTextEditor.
	 */
	static function stepperTextEditorFactory():TextBlockTextEditor {
		// we're only using this text editor in the NumericStepper because
		// isEditable is false on the TextInput. this text editor is not
		// suitable for mobile use if the TextInput needs to be editable
		// because it can't use the soft keyboard or other mobile-friendly UI
		return new TextBlockTextEditor();
	}

	/**
	 * The pop-up factory for a PickerList creates a SpinnerList.
	 */
	static function pickerListSpinnerListFactory():SpinnerList {
		return new SpinnerList();
	}

	/**
	 * This theme's scroll bar type is SimpleScrollBar.
	 */
	static function scrollBarFactory():SimpleScrollBar {
		return new SimpleScrollBar();
	}

	static function popUpOverlayFactory():DisplayObject {
		var quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
		quad.alpha = MODAL_OVERLAY_ALPHA;
		return quad;
	}

	/**
	 * Constructor.
	 */
	public function new() {
		super();
	}

	/**
	 * A smaller font size for details.
	 */
	var smallFontSize:Int = 10;

	/**
	 * A normal font size.
	 */
	var regularFontSize:Int = 12;

	/**
	 * A larger font size for headers.
	 */
	var largeFontSize:Int = 14;

	/**
	 * An extra large font size.
	 */
	var extraLargeFontSize:Int = 18;

	/**
	 * The size, in pixels, of major regions in the grid. Used for sizing
	 * containers and larger UI controls.
	 */
	var gridSize:Int = 44;

	/**
	 * The size, in pixels, of minor regions in the grid. Used for larger
	 * padding and gaps.
	 */
	var gutterSize:Int = 12;

	/**
	 * The size, in pixels, of smaller padding and gaps within the major
	 * regions in the grid.
	 */
	var smallGutterSize:Int = 8;

	/**
	 * The size, in pixels, of smaller padding and gaps within controls.
	 */
	var smallControlGutterSize:Int = 6;

	/**
	 * The width, in pixels, of UI controls that span across multiple grid regions.
	 */
	var wideControlSize:Int = 156;

	/**
	 * The size, in pixels, of a typical UI control.
	 */
	var controlSize:Int = 28;

	/**
	 * The size, in pixels, of smaller UI controls.
	 */
	var smallControlSize:Int = 12;

	/**
	 * The size, in pixels, of borders;
	 */
	var borderSize:Int = 1;

	var popUpFillSize:Int = 276;
	var calloutBackgroundMinSize:Int = 12;
	var calloutArrowOverlapGap:Int = -2;
	var scrollBarGutterSize:Int = 2;
	var focusPaddingSize:Int = -1;
	var tabFocusPaddingSize:Int = 4;

	/**
	 * The font styles for standard-sized, light text.
	 */
	var lightFontStyles:TextFormat;

	/**
	 * The font styles for standard-sized, dark text.
	 */
	var darkFontStyles:TextFormat;

	/**
	 * The font styles for standard-sized, selected text.
	 */
	var selectedFontStyles:TextFormat;

	/**
	 * The font styles for standard-sized, light, disabled text.
	 */
	var lightDisabledFontStyles:TextFormat;

	/**
	 * The font styles for small, light text.
	 */
	var smallLightFontStyles:TextFormat;

	/**
	 * The font styles for small, light, disabled text.
	 */
	var smallLightDisabledFontStyles:TextFormat;

	/**
	 * The font styles for large, light text.
	 */
	var largeLightFontStyles:TextFormat;

	/**
	 * The font styles for large, dark text.
	 */
	var largeDarkFontStyles:TextFormat;

	/**
	 * The font styles for large, light, disabled text.
	 */
	var largeLightDisabledFontStyles:TextFormat;

	/**
	 * The font styles for light UI text.
	 */
	var lightUIFontStyles:TextFormat;

	/**
	 * The font styles for dark UI text.
	 */
	var darkUIFontStyles:TextFormat;

	/**
	 * The font styles for selected UI text.
	 */
	var selectedUIFontStyles:TextFormat;

	/**
	 * The font styles for light, centered UI text.
	 */
	var lightCenteredUIFontStyles:TextFormat;

	/**
	 * The font styles for light, centered, disabled UI text.
	 */
	var lightCenteredDisabledUIFontStyles:TextFormat;

	/**
	 * The font styles for light disabled UI text.
	 */
	var lightDisabledUIFontStyles:TextFormat;

	/**
	 * The font styles for dark, disabled UI text.
	 */
	var darkDisabledUIFontStyles:TextFormat;

	/**
	 * The font styles for large, light UI text.
	 */
	var largeLightUIFontStyles:TextFormat;

	/**
	 * The font styles for large, dark UI text.
	 */
	var largeDarkUIFontStyles:TextFormat;

	/**
	 * The font styles for large, selected UI text.
	 */
	var largeSelectedUIFontStyles:TextFormat;

	/**
	 * The font styles for large, light, disabled UI text.
	 */
	var largeLightUIDisabledFontStyles:TextFormat;

	/**
	 * The font styles for large, dark, disabled UI text.
	 */
	var largeDarkUIDisabledFontStyles:TextFormat;

	/**
	 * The font styles for extra-large, light UI text.
	 */
	var xlargeLightUIFontStyles:TextFormat;

	/**
	 * The font styles for extra-large, light, disabled UI text.
	 */
	var xlargeLightUIDisabledFontStyles:TextFormat;

	/**
	 * The font styles for standard-sized, light text for a text input.
	 */
	var lightInputFontStyles:TextFormat;

	/**
	 * The font styles for standard-sized, light, disabled text for a text input.
	 */
	var lightDisabledInputFontStyles:TextFormat;

	/**
	 * ScrollText uses TextField instead of FTE, so it has a separate TextFormat.
	 */
	var lightScrollTextFontStyles:TextFormat;

	/**
	 * ScrollText uses TextField instead of FTE, so it has a separate disabled TextFormat.
	 */
	var lightDisabledScrollTextFontStyles:TextFormat;

	/**
	 * The texture atlas that contains skins for this theme. This base class
	 * does not initialize this member variable. Subclasses are expected to
	 * load the assets somehow and set the <code>atlas</code> member
	 * variable before calling <code>initialize()</code>.
	 */
	var atlas:TextureAtlas;

	var focusIndicatorSkinTexture:Texture;
	var headerBackgroundSkinTexture:Texture;
	var popUpHeaderBackgroundSkinTexture:Texture;
	var backgroundSkinTexture:Texture;
	var backgroundDisabledSkinTexture:Texture;
	var backgroundInsetSkinTexture:Texture;
	var backgroundInsetDisabledSkinTexture:Texture;
	var backgroundInsetFocusedSkinTexture:Texture;
	var backgroundInsetDangerSkinTexture:Texture;
	var backgroundLightBorderSkinTexture:Texture;
	var backgroundDarkBorderSkinTexture:Texture;
	var backgroundDangerBorderSkinTexture:Texture;
	var buttonUpSkinTexture:Texture;
	var buttonDownSkinTexture:Texture;
	var buttonDisabledSkinTexture:Texture;
	var buttonSelectedUpSkinTexture:Texture;
	var buttonSelectedDisabledSkinTexture:Texture;
	var buttonCallToActionUpSkinTexture:Texture;
	var buttonCallToActionDownSkinTexture:Texture;
	var buttonDangerUpSkinTexture:Texture;
	var buttonDangerDownSkinTexture:Texture;
	var buttonBackUpSkinTexture:Texture;
	var buttonBackDownSkinTexture:Texture;
	var buttonBackDisabledSkinTexture:Texture;
	var buttonForwardUpSkinTexture:Texture;
	var buttonForwardDownSkinTexture:Texture;
	var buttonForwardDisabledSkinTexture:Texture;
	var pickerListButtonIconTexture:Texture;
	var pickerListButtonSelectedIconTexture:Texture;
	var pickerListButtonIconDisabledTexture:Texture;
	var tabUpSkinTexture:Texture;
	var tabDownSkinTexture:Texture;
	var tabDisabledSkinTexture:Texture;
	var tabSelectedUpSkinTexture:Texture;
	var tabSelectedDisabledSkinTexture:Texture;
	var pickerListItemSelectedIconTexture:Texture;
	var spinnerListSelectionOverlaySkinTexture:Texture;
	var radioUpIconTexture:Texture;
	var radioDownIconTexture:Texture;
	var radioDisabledIconTexture:Texture;
	var radioSelectedUpIconTexture:Texture;
	var radioSelectedDownIconTexture:Texture;
	var radioSelectedDisabledIconTexture:Texture;
	var checkUpIconTexture:Texture;
	var checkDownIconTexture:Texture;
	var checkDisabledIconTexture:Texture;
	var checkSelectedUpIconTexture:Texture;
	var checkSelectedDownIconTexture:Texture;
	var checkSelectedDisabledIconTexture:Texture;
	var pageIndicatorNormalSkinTexture:Texture;
	var pageIndicatorSelectedSkinTexture:Texture;
	var itemRendererUpSkinTexture:Texture;
	var itemRendererSelectedSkinTexture:Texture;
	var insetItemRendererUpSkinTexture:Texture;
	var insetItemRendererSelectedSkinTexture:Texture;
	var insetItemRendererFirstUpSkinTexture:Texture;
	var insetItemRendererFirstSelectedSkinTexture:Texture;
	var insetItemRendererLastUpSkinTexture:Texture;
	var insetItemRendererLastSelectedSkinTexture:Texture;
	var insetItemRendererSingleUpSkinTexture:Texture;
	var insetItemRendererSingleSelectedSkinTexture:Texture;
	var calloutTopArrowSkinTexture:Texture;
	var calloutRightArrowSkinTexture:Texture;
	var calloutBottomArrowSkinTexture:Texture;
	var calloutLeftArrowSkinTexture:Texture;
	var dangerCalloutTopArrowSkinTexture:Texture;
	var dangerCalloutRightArrowSkinTexture:Texture;
	var dangerCalloutBottomArrowSkinTexture:Texture;
	var dangerCalloutLeftArrowSkinTexture:Texture;
	var verticalScrollBarThumbSkinTexture:Texture;
	var horizontalScrollBarThumbSkinTexture:Texture;
	var searchIconTexture:Texture;
	var searchIconDisabledTexture:Texture;
	var listDrillDownAccessoryTexture:Texture;
	var listDrillDownAccessorySelectedTexture:Texture;
	var treeDisclosureOpenIconTexture:Texture;
	var treeDisclosureOpenSelectedIconTexture:Texture;
	var treeDisclosureClosedIconTexture:Texture;
	var treeDisclosureClosedSelectedIconTexture:Texture;
	var dataGridHeaderSortAscendingIconTexture:Texture;
	var dataGridHeaderSortDescendingIconTexture:Texture;
	var dataGridHeaderDividerSkinTexture:Texture;
	var dataGridVerticalDividerSkinTexture:Texture;
	var dataGridColumnResizeSkinTexture:Texture;
	var dataGridColumnDropIndicatorSkinTexture:Texture;
	var dragHandleIcon:Texture;

	// media textures
	var playPauseButtonPlayUpIconTexture:Texture;
	var playPauseButtonPlayDownIconTexture:Texture;
	var playPauseButtonPauseUpIconTexture:Texture;
	var playPauseButtonPauseDownIconTexture:Texture;
	var overlayPlayPauseButtonPlayUpIconTexture:Texture;
	var overlayPlayPauseButtonPlayDownIconTexture:Texture;
	var fullScreenToggleButtonEnterUpIconTexture:Texture;
	var fullScreenToggleButtonEnterDownIconTexture:Texture;
	var fullScreenToggleButtonExitUpIconTexture:Texture;
	var fullScreenToggleButtonExitDownIconTexture:Texture;
	var muteToggleButtonLoudUpIconTexture:Texture;
	var muteToggleButtonLoudDownIconTexture:Texture;
	var muteToggleButtonMutedUpIconTexture:Texture;
	var muteToggleButtonMutedDownIconTexture:Texture;
	var volumeSliderMinimumTrackSkinTexture:Texture;
	var volumeSliderMaximumTrackSkinTexture:Texture;
	var seekSliderProgressSkinTexture:Texture;

	/**
	 * Disposes the atlas before calling super.dispose()
	 */
	override public function dispose() {
		if (this.atlas != null) {
			// if anything is keeping a reference to the texture, we don't
			// want it to keep a reference to the theme too.
			this.atlas.texture.root.onRestore = null;

			this.atlas.dispose();
			this.atlas = null;
		}

		// don't forget to call super.dispose()!
		super.dispose();
	}

	/**
	 * Initializes the theme. Expected to be called by subclasses after the
	 * assets have been loaded and the skin texture atlas has been created.
	 */
	function initialize() {
		this.initializeFonts();
		this.initializeTextures();
		this.initializeGlobals();
		this.initializeStage();
		this.initializeStyleProviders();
	}

	/**
	 * Sets the stage background color.
	 */
	function initializeStage() {
		this.starling.stage.color = PRIMARY_BACKGROUND_COLOR;
		this.starling.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
	}

	/**
	 * Initializes global variables (not including global style providers).
	 */
	function initializeGlobals() {
		FeathersControl.defaultTextRendererFactory = textRendererFactory;
		FeathersControl.defaultTextEditorFactory = textEditorFactory;

		PopUpManager.overlayFactory = popUpOverlayFactory;
		Callout.stagePadding = this.smallGutterSize;
		Toast.containerFactory = toastContainerFactory;

		var stage = this.starling.stage;
		FocusManager.setEnabledForStage(stage, true);
	}

	/**
	 * Initializes font sizes and formats.
	 */
	function initializeFonts() {
		this.lightFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.darkFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, DARK_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.lightDisabledFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.selectedFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, SELECTED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);

		this.smallLightFontStyles = new TextFormat(FONT_NAME, this.smallFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.smallLightDisabledFontStyles = new TextFormat(FONT_NAME, this.smallFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);

		this.largeLightFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeDarkFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, DARK_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeLightDisabledFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);

		this.lightUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.lightUIFontStyles.bold = true;
		this.darkUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, DARK_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.darkUIFontStyles.bold = true;
		this.selectedUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, SELECTED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.selectedUIFontStyles.bold = true;
		this.lightDisabledUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.lightDisabledUIFontStyles.bold = true;
		this.darkDisabledUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, DARK_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.darkDisabledUIFontStyles.bold = true;
		this.lightCenteredUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.CENTER, VerticalAlign.TOP);
		this.lightCenteredUIFontStyles.bold = true;
		this.lightCenteredDisabledUIFontStyles = new TextFormat(FONT_NAME, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.CENTER, VerticalAlign.TOP);
		this.lightCenteredDisabledUIFontStyles.bold = true;

		this.largeLightUIFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeLightUIFontStyles.bold = true;
		this.largeDarkUIFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, DARK_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeDarkUIFontStyles.bold = true;
		this.largeSelectedUIFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, SELECTED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeSelectedUIFontStyles.bold = true;
		this.largeLightUIDisabledFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT,
			VerticalAlign.TOP);
		this.largeLightUIDisabledFontStyles.bold = true;
		this.largeDarkUIDisabledFontStyles = new TextFormat(FONT_NAME, this.largeFontSize, DARK_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.largeDarkUIDisabledFontStyles.bold = true;

		this.xlargeLightUIFontStyles = new TextFormat(FONT_NAME, this.extraLargeFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.xlargeLightUIFontStyles.bold = true;
		this.xlargeLightUIDisabledFontStyles = new TextFormat(FONT_NAME, this.extraLargeFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT,
			VerticalAlign.TOP);
		this.xlargeLightUIDisabledFontStyles.bold = true;

		this.lightInputFontStyles = new TextFormat(FONT_NAME_STACK, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.lightDisabledInputFontStyles = new TextFormat(FONT_NAME_STACK, this.regularFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT,
			VerticalAlign.TOP);

		this.lightScrollTextFontStyles = new TextFormat(FONT_NAME_STACK, this.regularFontSize, LIGHT_TEXT_COLOR, HorizontalAlign.LEFT, VerticalAlign.TOP);
		this.lightDisabledScrollTextFontStyles = new TextFormat(FONT_NAME_STACK, this.regularFontSize, LIGHT_DISABLED_TEXT_COLOR, HorizontalAlign.LEFT,
			VerticalAlign.TOP);
	}

	/**
	 * Initializes the textures by extracting them from the atlas and
	 * setting up any scaling grids that are needed.
	 */
	function initializeTextures() {
		this.focusIndicatorSkinTexture = this.atlas.getTexture("focus-indicator-skin0000");

		this.backgroundSkinTexture = this.atlas.getTexture("background-skin0000");
		this.backgroundDisabledSkinTexture = this.atlas.getTexture("background-disabled-skin0000");
		this.backgroundInsetSkinTexture = this.atlas.getTexture("background-inset-skin0000");
		this.backgroundInsetDisabledSkinTexture = this.atlas.getTexture("background-inset-disabled-skin0000");
		this.backgroundInsetFocusedSkinTexture = this.atlas.getTexture("background-focused-skin0000");
		this.backgroundInsetDangerSkinTexture = this.atlas.getTexture("background-inset-danger-skin0000");
		this.backgroundLightBorderSkinTexture = this.atlas.getTexture("background-light-border-skin0000");
		this.backgroundDarkBorderSkinTexture = this.atlas.getTexture("background-dark-border-skin0000");
		this.backgroundDangerBorderSkinTexture = this.atlas.getTexture("background-danger-border-skin0000");

		this.buttonUpSkinTexture = this.atlas.getTexture("button-up-skin0000");
		this.buttonDownSkinTexture = this.atlas.getTexture("button-down-skin0000");
		this.buttonDisabledSkinTexture = this.atlas.getTexture("button-disabled-skin0000");
		this.buttonSelectedUpSkinTexture = this.atlas.getTexture("toggle-button-selected-up-skin0000");
		this.buttonSelectedDisabledSkinTexture = this.atlas.getTexture("toggle-button-selected-disabled-skin0000");
		this.buttonCallToActionUpSkinTexture = this.atlas.getTexture("call-to-action-button-up-skin0000");
		this.buttonCallToActionDownSkinTexture = this.atlas.getTexture("call-to-action-button-down-skin0000");
		this.buttonDangerUpSkinTexture = this.atlas.getTexture("danger-button-up-skin0000");
		this.buttonDangerDownSkinTexture = this.atlas.getTexture("danger-button-down-skin0000");
		this.buttonBackUpSkinTexture = this.atlas.getTexture("back-button-up-skin0000");
		this.buttonBackDownSkinTexture = this.atlas.getTexture("back-button-down-skin0000");
		this.buttonBackDisabledSkinTexture = this.atlas.getTexture("back-button-disabled-skin0000");
		this.buttonForwardUpSkinTexture = this.atlas.getTexture("forward-button-up-skin0000");
		this.buttonForwardDownSkinTexture = this.atlas.getTexture("forward-button-down-skin0000");
		this.buttonForwardDisabledSkinTexture = this.atlas.getTexture("forward-button-disabled-skin0000");

		this.tabUpSkinTexture = Texture.fromTexture(this.atlas.getTexture("tab-up-skin0000"), TAB_SKIN_TEXTURE_REGION);
		this.tabDownSkinTexture = Texture.fromTexture(this.atlas.getTexture("tab-down-skin0000"), TAB_SKIN_TEXTURE_REGION);
		this.tabDisabledSkinTexture = Texture.fromTexture(this.atlas.getTexture("tab-disabled-skin0000"), TAB_SKIN_TEXTURE_REGION);
		this.tabSelectedUpSkinTexture = Texture.fromTexture(this.atlas.getTexture("tab-selected-up-skin0000"), TAB_SKIN_TEXTURE_REGION);
		this.tabSelectedDisabledSkinTexture = Texture.fromTexture(this.atlas.getTexture("tab-selected-disabled-skin0000"), TAB_SKIN_TEXTURE_REGION);

		this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-button-icon0000");
		this.pickerListButtonSelectedIconTexture = this.atlas.getTexture("picker-list-button-selected-icon0000");
		this.pickerListButtonIconDisabledTexture = this.atlas.getTexture("picker-list-button-disabled-icon0000");
		this.pickerListItemSelectedIconTexture = this.atlas.getTexture("picker-list-item-renderer-selected-icon0000");

		this.spinnerListSelectionOverlaySkinTexture = this.atlas.getTexture("spinner-list-selection-overlay-skin0000");

		this.checkUpIconTexture = this.atlas.getTexture("check-up-icon0000");
		this.checkDownIconTexture = this.atlas.getTexture("check-down-icon0000");
		this.checkDisabledIconTexture = this.atlas.getTexture("check-disabled-icon0000");
		this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon0000");
		this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon0000");
		this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon0000");

		this.radioUpIconTexture = this.checkUpIconTexture;
		this.radioDownIconTexture = this.checkDownIconTexture;
		this.radioDisabledIconTexture = this.checkDisabledIconTexture;
		this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon0000");
		this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon0000");
		this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon0000");

		this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-symbol0000");
		this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-symbol0000");

		this.searchIconTexture = this.atlas.getTexture("search-icon0000");
		this.searchIconDisabledTexture = this.atlas.getTexture("search-disabled-icon0000");

		this.itemRendererUpSkinTexture = this.atlas.getTexture("item-renderer-up-skin0000");
		this.itemRendererSelectedSkinTexture = this.atlas.getTexture("item-renderer-selected-up-skin0000");
		this.insetItemRendererUpSkinTexture = this.atlas.getTexture("inset-item-renderer-up-skin0000");
		this.insetItemRendererSelectedSkinTexture = this.atlas.getTexture("inset-item-renderer-selected-up-skin0000");
		this.insetItemRendererFirstUpSkinTexture = this.atlas.getTexture("first-inset-item-renderer-up-skin0000");
		this.insetItemRendererFirstSelectedSkinTexture = this.atlas.getTexture("first-inset-item-renderer-selected-up-skin0000");
		this.insetItemRendererLastUpSkinTexture = this.atlas.getTexture("last-inset-item-renderer-up-skin0000");
		this.insetItemRendererLastSelectedSkinTexture = this.atlas.getTexture("last-inset-item-renderer-selected-up-skin0000");
		this.insetItemRendererSingleUpSkinTexture = this.atlas.getTexture("single-inset-item-renderer-up-skin0000");
		this.insetItemRendererSingleSelectedSkinTexture = this.atlas.getTexture("single-inset-item-renderer-selected-up-skin0000");

		this.dragHandleIcon = this.atlas.getTexture("drag-handle-icon0000");

		var headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin0000");
		var popUpHeaderBackgroundSkinTexture = this.atlas.getTexture("header-popup-background-skin0000");
		this.headerBackgroundSkinTexture = Texture.fromTexture(headerBackgroundSkinTexture, HEADER_SKIN_TEXTURE_REGION);
		this.popUpHeaderBackgroundSkinTexture = Texture.fromTexture(popUpHeaderBackgroundSkinTexture, HEADER_SKIN_TEXTURE_REGION);

		this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin0000");
		this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin0000");
		this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin0000");
		this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin0000");
		this.dangerCalloutTopArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-top-skin0000");
		this.dangerCalloutRightArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-right-skin0000");
		this.dangerCalloutBottomArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-bottom-skin0000");
		this.dangerCalloutLeftArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-left-skin0000");

		this.horizontalScrollBarThumbSkinTexture = this.atlas.getTexture("horizontal-simple-scroll-bar-thumb-skin0000");
		this.verticalScrollBarThumbSkinTexture = this.atlas.getTexture("vertical-simple-scroll-bar-thumb-skin0000");

		this.listDrillDownAccessoryTexture = this.atlas.getTexture("item-renderer-drill-down-accessory-icon0000");
		this.listDrillDownAccessorySelectedTexture = this.atlas.getTexture("item-renderer-drill-down-accessory-selected-icon0000");

		this.treeDisclosureOpenIconTexture = this.atlas.getTexture("tree-disclosure-open-icon0000");
		this.treeDisclosureOpenSelectedIconTexture = this.atlas.getTexture("tree-disclosure-open-selected-icon0000");
		this.treeDisclosureClosedIconTexture = this.atlas.getTexture("tree-disclosure-closed-icon0000");
		this.treeDisclosureClosedSelectedIconTexture = this.atlas.getTexture("tree-disclosure-closed-selected-icon0000");

		this.dataGridHeaderSortAscendingIconTexture = this.atlas.getTexture("data-grid-header-sort-ascending-icon0000");
		this.dataGridHeaderSortDescendingIconTexture = this.atlas.getTexture("data-grid-header-sort-descending-icon0000");
		this.dataGridHeaderDividerSkinTexture = this.atlas.getTexture("data-grid-header-divider-skin0000");
		this.dataGridVerticalDividerSkinTexture = this.atlas.getTexture("data-grid-vertical-divider-skin0000");
		this.dataGridColumnResizeSkinTexture = this.atlas.getTexture("data-grid-column-resize-skin0000");
		this.dataGridColumnDropIndicatorSkinTexture = this.atlas.getTexture("data-grid-column-drop-indicator-skin0000");

		this.playPauseButtonPlayUpIconTexture = this.atlas.getTexture("play-pause-toggle-button-play-up-icon0000");
		this.playPauseButtonPlayDownIconTexture = this.atlas.getTexture("play-pause-toggle-button-play-down-icon0000");
		this.playPauseButtonPauseUpIconTexture = this.atlas.getTexture("play-pause-toggle-button-pause-up-icon0000");
		this.playPauseButtonPauseDownIconTexture = this.atlas.getTexture("play-pause-toggle-button-pause-down-icon0000");
		this.overlayPlayPauseButtonPlayUpIconTexture = this.atlas.getTexture("overlay-play-pause-toggle-button-play-up-icon0000");
		this.overlayPlayPauseButtonPlayDownIconTexture = this.atlas.getTexture("overlay-play-pause-toggle-button-play-down-icon0000");
		this.fullScreenToggleButtonEnterUpIconTexture = this.atlas.getTexture("full-screen-toggle-button-enter-up-icon0000");
		this.fullScreenToggleButtonEnterDownIconTexture = this.atlas.getTexture("full-screen-toggle-button-enter-down-icon0000");
		this.fullScreenToggleButtonExitUpIconTexture = this.atlas.getTexture("full-screen-toggle-button-exit-up-icon0000");
		this.fullScreenToggleButtonExitDownIconTexture = this.atlas.getTexture("full-screen-toggle-button-exit-down-icon0000");
		this.muteToggleButtonMutedUpIconTexture = this.atlas.getTexture("mute-toggle-button-muted-up-icon0000");
		this.muteToggleButtonMutedDownIconTexture = this.atlas.getTexture("mute-toggle-button-muted-down-icon0000");
		this.muteToggleButtonLoudUpIconTexture = this.atlas.getTexture("mute-toggle-button-loud-up-icon0000");
		this.muteToggleButtonLoudDownIconTexture = this.atlas.getTexture("mute-toggle-button-loud-down-icon0000");
		this.volumeSliderMinimumTrackSkinTexture = this.atlas.getTexture("volume-slider-minimum-track-skin0000");
		this.volumeSliderMaximumTrackSkinTexture = this.atlas.getTexture("volume-slider-maximum-track-skin0000");
		this.seekSliderProgressSkinTexture = this.atlas.getTexture("seek-slider-progress-skin0000");
	}

	/**
	 * Sets global style providers for all components.
	 */
	function initializeStyleProviders() {
		// alert
		this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
		this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON, this.setAlertButtonGroupButtonStyles);
		this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPopUpHeaderStyles);

		// auto-complete
		this.getStyleProviderForClass(AutoComplete).defaultStyleFunction = this.setTextInputStyles;
		this.getStyleProviderForClass(List).setFunctionForStyleName(AutoComplete.DEFAULT_CHILD_STYLE_NAME_LIST, this.setDropDownListStyles);

		// button
		this.getStyleProviderForClass(Button).defaultStyleFunction = this.setButtonStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON, this.setCallToActionButtonStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON, this.setDangerButtonStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON, this.setBackButtonStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON, this.setForwardButtonStyles);

		// button group
		this.getStyleProviderForClass(ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
		this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);

		// callout
		this.getStyleProviderForClass(Callout).defaultStyleFunction = this.setCalloutStyles;

		// check
		this.getStyleProviderForClass(Check).defaultStyleFunction = this.setCheckStyles;

		// data grid
		this.getStyleProviderForClass(DataGrid).defaultStyleFunction = this.setDataGridStyles;
		this.getStyleProviderForClass(DefaultDataGridCellRenderer).defaultStyleFunction = this.setDataGridCellRendererStyles;
		this.getStyleProviderForClass(DefaultDataGridHeaderRenderer).defaultStyleFunction = this.setDataGridHeaderStyles;

		// date time spinner
		this.getStyleProviderForClass(DateTimeSpinner).defaultStyleFunction = this.setDateTimeSpinnerStyles;
		this.getStyleProviderForClass(DefaultListItemRenderer)
			.setFunctionForStyleName(THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER, this.setDateTimeSpinnerListItemRendererStyles);

		// drawers
		this.getStyleProviderForClass(Drawers).defaultStyleFunction = this.setDrawersStyles;

		// grouped list
		this.getStyleProviderForClass(GroupedList).defaultStyleFunction = this.setGroupedListStyles;
		this.getStyleProviderForClass(GroupedList)
			.setFunctionForStyleName(GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST, this.setInsetGroupedListStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER, this.setInsetGroupedListMiddleItemRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER, this.setInsetGroupedListFirstItemRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER, this.setInsetGroupedListLastItemRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER, this.setInsetGroupedListSingleItemRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(DefaultGroupedListItemRenderer.ALTERNATE_STYLE_NAME_DRILL_DOWN, this.setDrillDownItemRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListItemRenderer)
			.setFunctionForStyleName(DefaultGroupedListItemRenderer.ALTERNATE_STYLE_NAME_CHECK, this.setCheckItemRendererStyles);

		// header
		this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;

		// header and footer renderers for grouped list
		this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).defaultStyleFunction = this.setGroupedListHeaderRendererStyles;
		this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer)
			.setFunctionForStyleName(GroupedList.DEFAULT_CHILD_STYLE_NAME_FOOTER_RENDERER, this.setGroupedListFooterRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER, this.setInsetGroupedListHeaderRendererStyles);
		this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer)
			.setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER, this.setInsetGroupedListFooterRendererStyles);

		// labels
		this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
		this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_HEADING, this.setHeadingLabelStyles);
		this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_DETAIL, this.setDetailLabelStyles);

		// layout group
		this.getStyleProviderForClass(LayoutGroup).setFunctionForStyleName(LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR, setToolbarLayoutGroupStyles);

		// list
		this.getStyleProviderForClass(List).defaultStyleFunction = this.setListStyles;
		this.getStyleProviderForClass(DefaultListItemRenderer).defaultStyleFunction = this.setListItemRendererStyles;
		this.getStyleProviderForClass(DefaultListItemRenderer)
			.setFunctionForStyleName(DefaultListItemRenderer.ALTERNATE_STYLE_NAME_DRILL_DOWN, this.setDrillDownItemRendererStyles);
		this.getStyleProviderForClass(DefaultListItemRenderer)
			.setFunctionForStyleName(DefaultListItemRenderer.ALTERNATE_STYLE_NAME_CHECK, this.setCheckItemRendererStyles);

		// numeric stepper
		this.getStyleProviderForClass(NumericStepper).defaultStyleFunction = this.setNumericStepperStyles;
		this.getStyleProviderForClass(TextInput)
			.setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_STYLE_NAME_TEXT_INPUT, this.setNumericStepperTextInputStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON, this.setNumericStepperButtonStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON, this.setNumericStepperButtonStyles);

		// page indicator
		this.getStyleProviderForClass(PageIndicator).defaultStyleFunction = this.setPageIndicatorStyles;

		// panel
		this.getStyleProviderForClass(Panel).defaultStyleFunction = this.setPanelStyles;
		this.getStyleProviderForClass(Header).setFunctionForStyleName(Panel.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPopUpHeaderStyles);

		// panel screen
		this.getStyleProviderForClass(PanelScreen).defaultStyleFunction = this.setPanelScreenStyles;
		this.getStyleProviderForClass(Header).setFunctionForStyleName(PanelScreen.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPanelScreenHeaderStyles);

		// picker list (see also: list and item renderers)
		this.getStyleProviderForClass(PickerList).defaultStyleFunction = this.setPickerListStyles;
		this.getStyleProviderForClass(List).setFunctionForStyleName(PickerList.DEFAULT_CHILD_STYLE_NAME_LIST, this.setPickerListPopUpListStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setPickerListButtonStyles);
		this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setPickerListButtonStyles);
		this.getStyleProviderForClass(DefaultListItemRenderer)
			.setFunctionForStyleName(THEME_STYLE_NAME_TABLET_PICKER_LIST_ITEM_RENDERER, this.setPickerListItemRendererStyles);

		// progress bar
		this.getStyleProviderForClass(ProgressBar).defaultStyleFunction = this.setProgressBarStyles;

		// radio
		this.getStyleProviderForClass(Radio).defaultStyleFunction = this.setRadioStyles;

		// scroll container
		this.getStyleProviderForClass(ScrollContainer).defaultStyleFunction = this.setScrollContainerStyles;
		this.getStyleProviderForClass(ScrollContainer)
			.setFunctionForStyleName(ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR, this.setToolbarScrollContainerStyles);

		// scroll screen
		this.getStyleProviderForClass(ScrollScreen).defaultStyleFunction = this.setScrollScreenStyles;

		// scroll text
		this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;

		// simple scroll bar
		this.getStyleProviderForClass(SimpleScrollBar).defaultStyleFunction = this.setSimpleScrollBarStyles;
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB, this.setHorizontalSimpleScrollBarThumbStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB, this.setVerticalSimpleScrollBarThumbStyles);

		// slider
		this.getStyleProviderForClass(Slider).defaultStyleFunction = this.setSliderStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(Slider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK, this.setHorizontalSliderMinimumTrackStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK, this.setHorizontalSliderMaximumTrackStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK, this.setVerticalSliderMinimumTrackStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK, this.setVerticalSliderMaximumTrackStyles);

		// spinner list
		this.getStyleProviderForClass(SpinnerList).defaultStyleFunction = this.setSpinnerListStyles;
		this.getStyleProviderForClass(DefaultListItemRenderer)
			.setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER, this.setSpinnerListItemRendererStyles);

		// tab bar
		this.getStyleProviderForClass(TabBar).defaultStyleFunction = this.setTabBarStyles;
		this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(TabBar.DEFAULT_CHILD_STYLE_NAME_TAB, this.setTabStyles);

		// text input
		this.getStyleProviderForClass(TextInput).defaultStyleFunction = this.setTextInputStyles;
		this.getStyleProviderForClass(TextInput).setFunctionForStyleName(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT, this.setSearchTextInputStyles);
		this.getStyleProviderForClass(TextCallout)
			.setFunctionForStyleName(TextInput.DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT, this.setTextInputErrorCalloutStyles);

		// text area
		this.getStyleProviderForClass(TextArea).defaultStyleFunction = this.setTextAreaStyles;
		this.getStyleProviderForClass(TextCallout)
			.setFunctionForStyleName(TextArea.DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT, this.setTextAreaErrorCalloutStyles);

		// text callout
		this.getStyleProviderForClass(TextCallout).defaultStyleFunction = this.setTextCalloutStyles;

		// toast
		this.getStyleProviderForClass(Toast).defaultStyleFunction = this.setToastStyles;
		this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Toast.DEFAULT_CHILD_STYLE_NAME_ACTIONS, this.setToastActionsStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_TOAST_ACTIONS_BUTTON, this.setToastActionsButtonStyles);

		// toggle button
		this.getStyleProviderForClass(ToggleButton).defaultStyleFunction = this.setButtonStyles;
		this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);

		// toggle switch
		this.getStyleProviderForClass(ToggleSwitch).defaultStyleFunction = this.setToggleSwitchStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
		this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK, this.setToggleSwitchTrackStyles);
		// we don't need a style function for the off track in this theme
		// the toggle switch layout uses a single track

		// tree
		this.getStyleProviderForClass(Tree).defaultStyleFunction = this.setTreeStyles;
		this.getStyleProviderForClass(DefaultTreeItemRenderer).defaultStyleFunction = this.setTreeItemRendererStyles;

		// media controls

		// play/pause toggle button
		this.getStyleProviderForClass(PlayPauseToggleButton).defaultStyleFunction = this.setPlayPauseToggleButtonStyles;
		this.getStyleProviderForClass(PlayPauseToggleButton)
			.setFunctionForStyleName(PlayPauseToggleButton.ALTERNATE_STYLE_NAME_OVERLAY_PLAY_PAUSE_TOGGLE_BUTTON, this.setOverlayPlayPauseToggleButtonStyles);

		// full screen toggle button
		this.getStyleProviderForClass(FullScreenToggleButton).defaultStyleFunction = this.setFullScreenToggleButtonStyles;

		// mute toggle button
		this.getStyleProviderForClass(MuteToggleButton).defaultStyleFunction = this.setMuteToggleButtonStyles;

		// seek slider
		this.getStyleProviderForClass(SeekSlider).defaultStyleFunction = this.setSeekSliderStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(SeekSlider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSeekSliderThumbStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(SeekSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK, this.setSeekSliderMinimumTrackStyles);
		this.getStyleProviderForClass(Button).setFunctionForStyleName(SeekSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK, this.setSeekSliderMaximumTrackStyles);

		// volume slider
		this.getStyleProviderForClass(VolumeSlider).defaultStyleFunction = this.setVolumeSliderStyles;
		this.getStyleProviderForClass(Button).setFunctionForStyleName(VolumeSlider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setVolumeSliderThumbStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK, this.setVolumeSliderMinimumTrackStyles);
		this.getStyleProviderForClass(Button)
			.setFunctionForStyleName(VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK, this.setVolumeSliderMaximumTrackStyles);
	}

	function pageIndicatorNormalSymbolFactory():DisplayObject {
		var symbol = new ImageLoader();
		symbol.source = this.pageIndicatorNormalSkinTexture;
		return symbol;
	}

	function pageIndicatorSelectedSymbolFactory():DisplayObject {
		var symbol = new ImageLoader();
		symbol.source = this.pageIndicatorSelectedSkinTexture;
		return symbol;
	}

	function dataGridHeaderDividerFactory():DisplayObject {
		var skin = new ImageSkin(this.dataGridHeaderDividerSkinTexture);
		skin.scale9Grid = DATA_GRID_HEADER_DIVIDER_SCALE_9_GRID;
		skin.minTouchWidth = this.controlSize;
		return skin;
	}

	function dataGridVerticalDividerFactory():DisplayObject {
		var skin = new ImageSkin(this.dataGridVerticalDividerSkinTexture);
		skin.scale9Grid = DATA_GRID_VERTICAL_DIVIDER_SCALE_9_GRID;
		return skin;
	}

	function toastContainerFactory():DisplayObjectContainer {
		var container = new LayoutGroup();
		container.autoSizeMode = AutoSizeMode.STAGE;

		var layout = new VerticalLayout();
		layout.verticalAlign = VerticalAlign.BOTTOM;
		if (DeviceCapabilities.isPhone()) {
			layout.horizontalAlign = HorizontalAlign.JUSTIFY;
			layout.padding = this.smallGutterSize;
			layout.gap = this.smallGutterSize;
		} else {
			layout.horizontalAlign = HorizontalAlign.LEFT;
			layout.padding = this.gutterSize;
			layout.gap = this.gutterSize;
		}
		container.layout = layout;
		return container;
	}

	//-------------------------
	// Shared
	//-------------------------

	function setScrollerStyles(scroller:Scroller) {
		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		scroller.focusIndicatorSkin = focusIndicatorSkin;
		scroller.focusPadding = 0;

		scroller.horizontalScrollBarFactory = scrollBarFactory;
		scroller.verticalScrollBarFactory = scrollBarFactory;
	}

	function setSimpleButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		skin.scale9Grid = BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		button.hasLabelTextRenderer = false;

		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	function setDropDownListStyles(list:List) {
		var backgroundSkin = new ImageSkin(this.itemRendererUpSkinTexture);
		backgroundSkin.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
		backgroundSkin.width = this.gridSize;
		backgroundSkin.height = this.gridSize;
		backgroundSkin.minWidth = this.gridSize;
		backgroundSkin.minHeight = this.gridSize;
		list.backgroundSkin = backgroundSkin;

		var layout = new VerticalLayout();
		layout.horizontalAlign = HorizontalAlign.JUSTIFY;
		layout.maxRowCount = 4;
		list.layout = layout;
	}

	//-------------------------
	// Alert
	//-------------------------

	function setAlertStyles(alert:Alert) {
		this.setScrollerStyles(alert);

		var backgroundSkin = new Image(this.backgroundLightBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		alert.backgroundSkin = backgroundSkin;

		alert.fontStyles = this.lightFontStyles.clone();

		alert.paddingTop = this.gutterSize;
		alert.paddingRight = this.gutterSize;
		alert.paddingBottom = this.smallGutterSize;
		alert.paddingLeft = this.gutterSize;
		alert.outerPadding = this.borderSize;
		alert.gap = this.smallGutterSize;
		alert.maxWidth = this.popUpFillSize;
		alert.maxHeight = this.popUpFillSize;
	}

	// see Panel section for Header styles

	function setAlertButtonGroupStyles(group:ButtonGroup) {
		group.direction = Direction.HORIZONTAL;
		group.horizontalAlign = HorizontalAlign.CENTER;
		group.verticalAlign = VerticalAlign.JUSTIFY;
		group.distributeButtonSizes = false;
		group.gap = this.smallGutterSize;
		group.padding = this.smallGutterSize;
		group.customButtonStyleName = THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON;
	}

	function setAlertButtonGroupButtonStyles(button:Button) {
		this.setButtonStyles(button);

		var skin = cast(button.defaultSkin, ImageSkin);
		skin.minWidth = 2 * this.controlSize;
	}

	//-------------------------
	// Button
	//-------------------------

	function setBaseButtonStyles(button:Button) {
		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		button.focusIndicatorSkin = focusIndicatorSkin;
		button.focusPadding = this.focusPaddingSize;

		button.paddingTop = this.smallControlGutterSize;
		button.paddingBottom = this.smallControlGutterSize;
		button.paddingLeft = this.gutterSize;
		button.paddingRight = this.gutterSize;
		button.gap = this.smallControlGutterSize;
		button.minGap = this.smallControlGutterSize;
		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	function setButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		if (Std.isOfType(button, ToggleButton)) {
			// for convenience, this function can style both a regular button
			// and a toggle button
			skin.selectedTexture = this.buttonSelectedUpSkinTexture;
			skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
		}
		skin.scale9Grid = BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		button.focusIndicatorSkin = focusIndicatorSkin;
		button.focusPadding = this.focusPaddingSize;

		button.fontStyles = this.darkUIFontStyles.clone();
		button.disabledFontStyles = this.darkDisabledUIFontStyles.clone();

		this.setBaseButtonStyles(button);
	}

	function setCallToActionButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonCallToActionUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonCallToActionDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		skin.scale9Grid = BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		button.fontStyles = this.darkUIFontStyles.clone();
		button.disabledFontStyles = this.darkDisabledUIFontStyles.clone();

		this.setBaseButtonStyles(button);
	}

	function setQuietButtonStyles(button:Button) {
		var defaultSkin = new Quad(this.controlSize, this.controlSize, 0xff00ff);
		defaultSkin.alpha = 0;
		button.defaultSkin = defaultSkin;

		var otherSkin = new ImageSkin(null);
		otherSkin.setTextureForState(ButtonState.DOWN, this.buttonDownSkinTexture);
		otherSkin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		button.downSkin = otherSkin;
		button.disabledSkin = otherSkin;
		var toggleButton:ToggleButton = null;
		if (Std.isOfType(button, ToggleButton)) {
			// for convenience, this function can style both a regular button
			// and a toggle button
			toggleButton = cast(button, ToggleButton);
			otherSkin.selectedTexture = this.buttonSelectedUpSkinTexture;
			toggleButton.defaultSelectedSkin = otherSkin;
		}
		otherSkin.scale9Grid = BUTTON_SCALE9_GRID;
		otherSkin.width = this.controlSize;
		otherSkin.height = this.controlSize;
		otherSkin.minWidth = this.controlSize;
		otherSkin.minHeight = this.controlSize;

		button.fontStyles = this.lightUIFontStyles.clone();
		button.setFontStylesForState(ButtonState.DOWN, this.darkUIFontStyles.clone());
		button.setFontStylesForState(ButtonState.DISABLED, this.lightDisabledUIFontStyles.clone());
		if (Std.isOfType(button, ToggleButton)) {
			// for convenience, this function can style both a regular button
			// and a toggle button
			toggleButton.selectedFontStyles = this.darkUIFontStyles.clone();
			toggleButton.setFontStylesForState(ButtonState.DISABLED_AND_SELECTED, this.darkDisabledUIFontStyles.clone());
		}

		button.paddingTop = this.smallControlGutterSize;
		button.paddingBottom = this.smallControlGutterSize;
		button.paddingLeft = this.smallGutterSize;
		button.paddingRight = this.smallGutterSize;
		button.gap = this.smallControlGutterSize;
		button.minGap = this.smallControlGutterSize;
		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		button.focusIndicatorSkin = focusIndicatorSkin;
		button.focusPadding = this.focusPaddingSize;
	}

	function setDangerButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonDangerUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonDangerDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		skin.scale9Grid = BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		button.fontStyles = this.darkUIFontStyles.clone();
		button.disabledFontStyles = this.darkDisabledUIFontStyles.clone();

		this.setBaseButtonStyles(button);
	}

	function setBackButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonBackUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonBackDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonBackDisabledSkinTexture);
		skin.scale9Grid = BACK_BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		button.fontStyles = this.darkUIFontStyles.clone();
		button.disabledFontStyles = this.darkDisabledUIFontStyles.clone();

		this.setBaseButtonStyles(button);

		button.paddingLeft = this.gutterSize + this.smallGutterSize;
	}

	function setForwardButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonForwardUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonForwardDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonForwardDisabledSkinTexture);
		skin.scale9Grid = FORWARD_BUTTON_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		button.defaultSkin = skin;

		button.fontStyles = this.darkUIFontStyles.clone();
		button.disabledFontStyles = this.darkDisabledUIFontStyles.clone();

		this.setBaseButtonStyles(button);

		button.paddingRight = this.gutterSize + this.smallGutterSize;
	}

	//-------------------------
	// ButtonGroup
	//-------------------------

	function setButtonGroupStyles(group:ButtonGroup) {
		group.gap = this.smallGutterSize;
	}

	function setButtonGroupButtonStyles(button:Button) {
		var skin = new ImageSkin(this.buttonUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.buttonDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.buttonDisabledSkinTexture);
		if (Std.isOfType(button, ToggleButton)) {
			// for convenience, this function can style both a regular button
			// and a toggle button
			skin.selectedTexture = this.buttonSelectedUpSkinTexture;
			skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
		}
		skin.scale9Grid = BUTTON_SCALE9_GRID;
		skin.width = this.popUpFillSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		button.defaultSkin = skin;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		button.focusIndicatorSkin = focusIndicatorSkin;
		button.focusPadding = this.focusPaddingSize;

		button.fontStyles = this.largeDarkUIFontStyles.clone();
		button.disabledFontStyles = this.largeDarkUIDisabledFontStyles.clone();

		button.paddingTop = this.smallGutterSize;
		button.paddingBottom = this.smallGutterSize;
		button.paddingLeft = this.gutterSize;
		button.paddingRight = this.gutterSize;
		button.gap = this.smallGutterSize;
		button.minGap = this.smallGutterSize;
		button.horizontalAlign = HorizontalAlign.CENTER;
		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// Callout
	//-------------------------

	function setCalloutStyles(callout:Callout) {
		var backgroundSkin = new Image(this.backgroundLightBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		backgroundSkin.width = this.calloutBackgroundMinSize;
		backgroundSkin.height = this.calloutBackgroundMinSize;
		callout.backgroundSkin = backgroundSkin;

		var topArrowSkin = new Image(this.calloutTopArrowSkinTexture);
		callout.topArrowSkin = topArrowSkin;
		callout.topArrowGap = this.calloutArrowOverlapGap;

		var rightArrowSkin = new Image(this.calloutRightArrowSkinTexture);
		callout.rightArrowSkin = rightArrowSkin;
		callout.rightArrowGap = this.calloutArrowOverlapGap;

		var bottomArrowSkin = new Image(this.calloutBottomArrowSkinTexture);
		callout.bottomArrowSkin = bottomArrowSkin;
		callout.bottomArrowGap = this.calloutArrowOverlapGap;

		var leftArrowSkin = new Image(this.calloutLeftArrowSkinTexture);
		callout.leftArrowSkin = leftArrowSkin;
		callout.leftArrowGap = this.calloutArrowOverlapGap;

		callout.padding = this.smallGutterSize;
	}

	function setDangerCalloutStyles(callout:Callout) {
		var backgroundSkin = new Image(this.backgroundDangerBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		backgroundSkin.width = this.calloutBackgroundMinSize;
		backgroundSkin.height = this.calloutBackgroundMinSize;
		callout.backgroundSkin = backgroundSkin;

		var topArrowSkin = new Image(this.dangerCalloutTopArrowSkinTexture);
		callout.topArrowSkin = topArrowSkin;
		callout.topArrowGap = this.calloutArrowOverlapGap;

		var rightArrowSkin = new Image(this.dangerCalloutRightArrowSkinTexture);
		callout.rightArrowSkin = rightArrowSkin;
		callout.rightArrowGap = this.calloutArrowOverlapGap;

		var bottomArrowSkin = new Image(this.dangerCalloutBottomArrowSkinTexture);
		callout.bottomArrowSkin = bottomArrowSkin;
		callout.bottomArrowGap = this.calloutArrowOverlapGap;

		var leftArrowSkin = new Image(this.dangerCalloutLeftArrowSkinTexture);
		callout.leftArrowSkin = leftArrowSkin;
		callout.leftArrowGap = this.calloutArrowOverlapGap;

		callout.padding = this.smallGutterSize;
	}

	//-------------------------
	// Check
	//-------------------------

	function setCheckStyles(check:Check) {
		var skin = new Quad(this.controlSize, this.controlSize);
		skin.alpha = 0;
		check.defaultSkin = skin;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		check.focusIndicatorSkin = focusIndicatorSkin;
		check.focusPadding = this.focusPaddingSize;

		var icon = new ImageSkin(this.checkUpIconTexture);
		icon.selectedTexture = this.checkSelectedUpIconTexture;
		icon.setTextureForState(ButtonState.DOWN, this.checkDownIconTexture);
		icon.setTextureForState(ButtonState.DISABLED, this.checkDisabledIconTexture);
		icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.checkSelectedDownIconTexture);
		icon.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.checkSelectedDisabledIconTexture);
		check.defaultIcon = icon;

		check.fontStyles = this.lightUIFontStyles.clone();
		check.disabledFontStyles = this.lightDisabledUIFontStyles.clone();

		check.horizontalAlign = HorizontalAlign.LEFT;
		check.gap = this.smallControlGutterSize;
		check.minGap = this.smallControlGutterSize;
		check.minTouchWidth = this.gridSize;
		check.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// DataGrid
	//-------------------------

	function setDataGridStyles(grid:DataGrid) {
		this.setScrollerStyles(grid);
		var backgroundSkin = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
		grid.backgroundSkin = backgroundSkin;

		var columnResizeSkin = new ImageSkin(this.dataGridColumnResizeSkinTexture);
		columnResizeSkin.scale9Grid = DATA_GRID_COLUMN_RESIZE_SCALE_9_GRID;
		grid.columnResizeSkin = columnResizeSkin;

		var columnDropIndicatorSkin = new ImageSkin(this.dataGridColumnDropIndicatorSkinTexture);
		columnDropIndicatorSkin.scale9Grid = DATA_GRID_COLUMN_DROP_INDICATOR_SCALE_9_GRID;
		grid.columnDropIndicatorSkin = columnDropIndicatorSkin;
		grid.extendedColumnDropIndicator = true;

		var columnDragOverlaySkin = new Quad(1, 1, DATA_GRID_COLUMN_OVERLAY_COLOR);
		columnDragOverlaySkin.alpha = DATA_GRID_COLUMN_OVERLAY_ALPHA;
		grid.columnDragOverlaySkin = columnDragOverlaySkin;

		grid.headerDividerFactory = this.dataGridHeaderDividerFactory;
		grid.verticalDividerFactory = this.dataGridVerticalDividerFactory;
	}

	function setDataGridHeaderStyles(headerRenderer:DefaultDataGridHeaderRenderer) {
		headerRenderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR);

		headerRenderer.sortAscendingIcon = new ImageSkin(this.dataGridHeaderSortAscendingIconTexture);
		headerRenderer.sortDescendingIcon = new ImageSkin(this.dataGridHeaderSortDescendingIconTexture);

		headerRenderer.fontStyles = this.lightUIFontStyles;
		headerRenderer.disabledFontStyles = this.lightDisabledUIFontStyles;
		headerRenderer.padding = this.smallGutterSize;
	}

	function setDataGridCellRendererStyles(cellRenderer:DefaultDataGridCellRenderer) {
		var skin = new ImageSkin(this.itemRendererUpSkinTexture);
		skin.selectedTexture = this.itemRendererSelectedSkinTexture;
		skin.setTextureForState(ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
		skin.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
		skin.width = this.gridSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		cellRenderer.defaultSkin = skin;

		cellRenderer.fontStyles = this.largeLightFontStyles.clone();
		cellRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
		cellRenderer.selectedFontStyles = this.largeDarkFontStyles.clone();
		cellRenderer.setFontStylesForState(ButtonState.DOWN, this.largeDarkFontStyles.clone());

		cellRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		cellRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		cellRenderer.iconLabelSelectedFontStyles = this.darkFontStyles.clone();
		cellRenderer.setIconLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		cellRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		cellRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		cellRenderer.accessoryLabelSelectedFontStyles = this.darkFontStyles.clone();
		cellRenderer.setAccessoryLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		cellRenderer.horizontalAlign = HorizontalAlign.LEFT;
		cellRenderer.paddingTop = this.smallGutterSize;
		cellRenderer.paddingBottom = this.smallGutterSize;
		cellRenderer.paddingLeft = this.gutterSize;
		cellRenderer.paddingRight = this.gutterSize;
		cellRenderer.gap = this.gutterSize;
		cellRenderer.minGap = this.gutterSize;
		cellRenderer.iconPosition = RelativePosition.LEFT;
		cellRenderer.accessoryGap = ASCompat.MAX_FLOAT;
		cellRenderer.minAccessoryGap = this.gutterSize;
		cellRenderer.accessoryPosition = RelativePosition.RIGHT;
		cellRenderer.minTouchWidth = this.gridSize;
		cellRenderer.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// DateTimeSpinner
	//-------------------------

	function setDateTimeSpinnerStyles(spinner:DateTimeSpinner) {
		spinner.customItemRendererStyleName = THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER;
	}

	function setDateTimeSpinnerListItemRendererStyles(itemRenderer:DefaultListItemRenderer) {
		this.setSpinnerListItemRendererStyles(itemRenderer);

		itemRenderer.accessoryPosition = RelativePosition.LEFT;
		itemRenderer.gap = this.smallGutterSize;
		itemRenderer.minGap = this.smallGutterSize;
		itemRenderer.accessoryGap = this.smallGutterSize;
		itemRenderer.minAccessoryGap = this.smallGutterSize;
	}

	//-------------------------
	// Drawers
	//-------------------------

	function setDrawersStyles(drawers:Drawers) {
		var overlaySkin = new Quad(10, 10, DRAWER_OVERLAY_COLOR);
		overlaySkin.alpha = DRAWER_OVERLAY_ALPHA;
		drawers.overlaySkin = overlaySkin;

		var topDrawerDivider = new Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
		drawers.topDrawerDivider = topDrawerDivider;

		var rightDrawerDivider = new Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
		drawers.rightDrawerDivider = rightDrawerDivider;

		var bottomDrawerDivider = new Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
		drawers.bottomDrawerDivider = bottomDrawerDivider;

		var leftDrawerDivider = new Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
		drawers.leftDrawerDivider = leftDrawerDivider;
	}

	//-------------------------
	// GroupedList
	//-------------------------

	function setGroupedListStyles(list:GroupedList) {
		this.setScrollerStyles(list);
		var backgroundSkin = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
		list.backgroundSkin = backgroundSkin;
	}

	// see List section for item renderer styles

	function setGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer) {
		renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR);

		renderer.fontStyles = this.lightUIFontStyles.clone();
		renderer.disabledFontStyles = this.lightDisabledUIFontStyles.clone();

		renderer.horizontalAlign = HorizontalAlign.LEFT;
		renderer.paddingTop = this.smallGutterSize;
		renderer.paddingBottom = this.smallGutterSize;
		renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
		renderer.paddingRight = this.gutterSize;
	}

	function setGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer) {
		renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);

		renderer.fontStyles = this.lightFontStyles.clone();
		renderer.disabledFontStyles = this.lightDisabledFontStyles.clone();

		renderer.horizontalAlign = HorizontalAlign.CENTER;
		renderer.paddingTop = renderer.paddingBottom = this.smallGutterSize;
		renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
		renderer.paddingRight = this.gutterSize;
	}

	function setInsetGroupedListStyles(list:GroupedList) {
		list.customItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER;
		list.customFirstItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER;
		list.customLastItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER;
		list.customSingleItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER;
		list.customHeaderRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER;
		list.customFooterRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER;

		var layout = new VerticalLayout();
		layout.useVirtualLayout = true;
		layout.padding = this.smallGutterSize;
		layout.gap = 0;
		layout.horizontalAlign = HorizontalAlign.JUSTIFY;
		layout.verticalAlign = VerticalAlign.TOP;
		list.layout = layout;
	}

	function setInsetGroupedListItemRendererStyles(itemRenderer:DefaultGroupedListItemRenderer, defaultSkinTexture:Texture,
			selectedAndDownSkinTexture:Texture, scale9Grid:Rectangle) {
		var skin = new ImageSkin(defaultSkinTexture);
		skin.selectedTexture = selectedAndDownSkinTexture;
		skin.setTextureForState(ButtonState.DOWN, selectedAndDownSkinTexture);
		skin.scale9Grid = scale9Grid;
		skin.width = this.gridSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		itemRenderer.defaultSkin = skin;

		itemRenderer.fontStyles = this.largeLightFontStyles.clone();
		itemRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
		itemRenderer.selectedFontStyles = this.largeDarkFontStyles.clone();
		itemRenderer.setFontStylesForState(ButtonState.DOWN, this.largeDarkFontStyles.clone());

		itemRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.iconLabelSelectedFontStyles = this.darkFontStyles.clone();
		itemRenderer.setIconLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.accessoryLabelSelectedFontStyles = this.darkFontStyles.clone();
		itemRenderer.setAccessoryLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
		itemRenderer.paddingTop = this.smallGutterSize;
		itemRenderer.paddingBottom = this.smallGutterSize;
		itemRenderer.paddingLeft = this.gutterSize + this.smallGutterSize;
		itemRenderer.paddingRight = this.gutterSize;
		itemRenderer.gap = this.gutterSize;
		itemRenderer.minGap = this.gutterSize;
		itemRenderer.iconPosition = RelativePosition.LEFT;
		itemRenderer.accessoryGap = ASCompat.MAX_FLOAT;
		itemRenderer.minAccessoryGap = this.gutterSize;
		itemRenderer.accessoryPosition = RelativePosition.RIGHT;
		itemRenderer.minTouchWidth = this.gridSize;
		itemRenderer.minTouchHeight = this.gridSize;
	}

	function setInsetGroupedListMiddleItemRendererStyles(renderer:DefaultGroupedListItemRenderer) {
		this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererUpSkinTexture, this.insetItemRendererSelectedSkinTexture,
			INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID);
	}

	function setInsetGroupedListFirstItemRendererStyles(renderer:DefaultGroupedListItemRenderer) {
		this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererFirstUpSkinTexture, this.insetItemRendererFirstSelectedSkinTexture,
			INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
	}

	function setInsetGroupedListLastItemRendererStyles(renderer:DefaultGroupedListItemRenderer) {
		this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererLastUpSkinTexture, this.insetItemRendererLastSelectedSkinTexture,
			INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
	}

	function setInsetGroupedListSingleItemRendererStyles(renderer:DefaultGroupedListItemRenderer) {
		this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererSingleUpSkinTexture, this.insetItemRendererSingleSelectedSkinTexture,
			INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
	}

	function setInsetGroupedListHeaderRendererStyles(headerRenderer:DefaultGroupedListHeaderOrFooterRenderer) {
		var defaultSkin = new Quad(this.controlSize, this.controlSize, 0xff00ff);
		defaultSkin.alpha = 0;
		headerRenderer.backgroundSkin = defaultSkin;

		headerRenderer.fontStyles = this.lightUIFontStyles.clone();
		headerRenderer.disabledFontStyles = this.lightDisabledUIFontStyles.clone();

		headerRenderer.horizontalAlign = HorizontalAlign.LEFT;
		headerRenderer.paddingTop = this.smallGutterSize;
		headerRenderer.paddingBottom = this.smallGutterSize;
		headerRenderer.paddingLeft = this.gutterSize + this.smallGutterSize;
		headerRenderer.paddingRight = this.gutterSize;
	}

	function setInsetGroupedListFooterRendererStyles(footerRenderer:DefaultGroupedListHeaderOrFooterRenderer) {
		var defaultSkin = new Quad(this.controlSize, this.controlSize, 0xff00ff);
		defaultSkin.alpha = 0;
		footerRenderer.backgroundSkin = defaultSkin;

		footerRenderer.fontStyles = this.lightFontStyles.clone();
		footerRenderer.disabledFontStyles = this.lightDisabledFontStyles.clone();

		footerRenderer.horizontalAlign = HorizontalAlign.CENTER;
		footerRenderer.paddingTop = this.smallGutterSize;
		footerRenderer.paddingBottom = this.smallGutterSize;
		footerRenderer.paddingLeft = this.gutterSize + this.smallGutterSize;
		footerRenderer.paddingRight = this.gutterSize;
	}

	//-------------------------
	// Header
	//-------------------------

	function setHeaderStyles(header:Header) {
		var backgroundSkin = new ImageSkin(this.headerBackgroundSkinTexture);
		backgroundSkin.tileGrid = new Rectangle();
		backgroundSkin.width = this.gridSize;
		backgroundSkin.height = this.gridSize;
		backgroundSkin.minWidth = this.gridSize;
		backgroundSkin.minHeight = this.gridSize;
		header.backgroundSkin = backgroundSkin;

		header.fontStyles = this.xlargeLightUIFontStyles.clone();
		header.disabledFontStyles = this.xlargeLightUIDisabledFontStyles.clone();

		header.padding = this.smallGutterSize;
		header.gap = this.smallGutterSize;
		header.titleGap = this.smallGutterSize;
	}

	//-------------------------
	// Label
	//-------------------------

	function setLabelStyles(label:Label) {
		label.fontStyles = this.lightFontStyles.clone();
		label.disabledFontStyles = this.lightDisabledFontStyles.clone();
	}

	function setHeadingLabelStyles(label:Label) {
		label.fontStyles = this.largeLightFontStyles.clone();
		label.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
	}

	function setDetailLabelStyles(label:Label) {
		label.fontStyles = this.smallLightFontStyles.clone();
		label.disabledFontStyles = this.smallLightDisabledFontStyles.clone();
	}

	//-------------------------
	// LayoutGroup
	//-------------------------

	function setToolbarLayoutGroupStyles(group:LayoutGroup) {
		if (group.layout == null) {
			var layout = new HorizontalLayout();
			layout.padding = this.smallGutterSize;
			layout.gap = this.smallGutterSize;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			group.layout = layout;
		}

		var backgroundSkin = new ImageSkin(this.headerBackgroundSkinTexture);
		backgroundSkin.tileGrid = new Rectangle();
		backgroundSkin.width = this.gridSize;
		backgroundSkin.height = this.gridSize;
		backgroundSkin.minWidth = this.gridSize;
		backgroundSkin.minHeight = this.gridSize;
		group.backgroundSkin = backgroundSkin;
	}

	//-------------------------
	// List
	//-------------------------

	function setListStyles(list:List) {
		this.setScrollerStyles(list);

		var backgroundSkin = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
		list.backgroundSkin = backgroundSkin;

		var dropIndicatorSkin = new Quad(this.borderSize, this.borderSize, LIGHT_TEXT_COLOR);
		list.dropIndicatorSkin = dropIndicatorSkin;
	}

	function setListItemRendererStyles(itemRenderer:DefaultListItemRenderer) {
		this.setItemRendererStyles(itemRenderer);

		var dragIcon = new ImageSkin(this.dragHandleIcon);
		dragIcon.minTouchWidth = this.gridSize;
		dragIcon.minTouchHeight = this.gridSize;
		itemRenderer.dragIcon = dragIcon;
	}

	function setItemRendererStyles(itemRenderer:BaseDefaultItemRenderer) {
		var skin = new ImageSkin(this.itemRendererUpSkinTexture);
		skin.selectedTexture = this.itemRendererSelectedSkinTexture;
		skin.setTextureForState(ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
		skin.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
		skin.width = this.gridSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		itemRenderer.defaultSkin = skin;

		itemRenderer.fontStyles = this.largeLightFontStyles.clone();
		itemRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
		itemRenderer.selectedFontStyles = this.largeDarkFontStyles.clone();
		itemRenderer.setFontStylesForState(ButtonState.DOWN, this.largeDarkFontStyles.clone());

		itemRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.iconLabelSelectedFontStyles = this.darkFontStyles.clone();
		itemRenderer.setIconLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.accessoryLabelSelectedFontStyles = this.darkFontStyles.clone();
		itemRenderer.setAccessoryLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
		itemRenderer.paddingTop = this.smallGutterSize;
		itemRenderer.paddingBottom = this.smallGutterSize;
		itemRenderer.paddingLeft = this.gutterSize;
		itemRenderer.paddingRight = this.gutterSize;
		itemRenderer.gap = this.gutterSize;
		itemRenderer.minGap = this.gutterSize;
		itemRenderer.iconPosition = RelativePosition.LEFT;
		itemRenderer.accessoryGap = ASCompat.MAX_FLOAT;
		itemRenderer.minAccessoryGap = this.gutterSize;
		itemRenderer.accessoryPosition = RelativePosition.RIGHT;
		itemRenderer.minTouchWidth = this.gridSize;
		itemRenderer.minTouchHeight = this.gridSize;
	}

	function setDrillDownItemRendererStyles(itemRenderer:DefaultListItemRenderer) {
		this.setItemRendererStyles(itemRenderer);

		itemRenderer.itemHasAccessory = false;

		var accessorySkin = new ImageSkin(this.listDrillDownAccessoryTexture);
		accessorySkin.selectedTexture = this.listDrillDownAccessorySelectedTexture;
		accessorySkin.setTextureForState(ButtonState.DOWN, this.listDrillDownAccessorySelectedTexture);
		itemRenderer.defaultAccessory = accessorySkin;
	}

	function setCheckItemRendererStyles(itemRenderer:BaseDefaultItemRenderer) {
		var skin = new ImageSkin(this.itemRendererUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
		skin.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
		skin.width = this.gridSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		itemRenderer.defaultSkin = skin;

		var defaultSelectedIcon = new ImageLoader();
		defaultSelectedIcon.source = this.pickerListItemSelectedIconTexture;
		itemRenderer.defaultSelectedIcon = defaultSelectedIcon;
		defaultSelectedIcon.validate();

		var defaultIcon = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
		defaultIcon.alpha = 0;
		itemRenderer.defaultIcon = defaultIcon;

		itemRenderer.fontStyles = this.largeLightFontStyles.clone();
		itemRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
		itemRenderer.setFontStylesForState(ButtonState.DOWN, this.largeDarkFontStyles.clone());

		itemRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.setIconLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.setAccessoryLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.itemHasIcon = false;
		itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
		itemRenderer.paddingTop = this.smallGutterSize;
		itemRenderer.paddingBottom = this.smallGutterSize;
		itemRenderer.paddingLeft = this.gutterSize;
		itemRenderer.paddingRight = this.gutterSize;
		itemRenderer.gap = ASCompat.MAX_FLOAT;
		itemRenderer.minGap = this.gutterSize;
		itemRenderer.iconPosition = RelativePosition.RIGHT;
		itemRenderer.accessoryGap = this.smallGutterSize;
		itemRenderer.minAccessoryGap = this.smallGutterSize;
		itemRenderer.accessoryPosition = RelativePosition.BOTTOM;
		itemRenderer.layoutOrder = ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON;
		itemRenderer.minTouchWidth = this.gridSize;
		itemRenderer.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// NumericStepper
	//-------------------------

	function setNumericStepperStyles(stepper:NumericStepper) {
		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		stepper.focusIndicatorSkin = focusIndicatorSkin;
		stepper.focusPadding = this.focusPaddingSize;

		stepper.useLeftAndRightKeys = true;

		stepper.buttonLayoutMode = StepperButtonLayoutMode.SPLIT_HORIZONTAL;
		stepper.incrementButtonLabel = "+";
		stepper.decrementButtonLabel = "-";
	}

	function setNumericStepperTextInputStyles(input:TextInput) {
		var backgroundSkin = new ImageSkin(this.backgroundSkinTexture);
		backgroundSkin.setTextureForState(TextInputState.DISABLED, this.backgroundDisabledSkinTexture);
		backgroundSkin.setTextureForState(TextInputState.FOCUSED, this.backgroundInsetFocusedSkinTexture);
		backgroundSkin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		backgroundSkin.width = this.controlSize;
		backgroundSkin.height = this.controlSize;
		backgroundSkin.minWidth = this.controlSize;
		backgroundSkin.minHeight = this.controlSize;
		input.backgroundSkin = backgroundSkin;

		input.textEditorFactory = stepperTextEditorFactory;
		input.fontStyles = this.lightCenteredUIFontStyles.clone();
		input.disabledFontStyles = this.lightCenteredDisabledUIFontStyles.clone();

		input.minTouchWidth = this.gridSize;
		input.minTouchHeight = this.gridSize;
		input.gap = this.smallControlGutterSize;
		input.paddingTop = this.smallControlGutterSize;
		input.paddingRight = this.smallGutterSize;
		input.paddingBottom = this.smallControlGutterSize;
		input.paddingLeft = this.smallGutterSize;
		input.isEditable = false;
		input.isSelectable = false;
	}

	function setNumericStepperButtonStyles(button:Button) {
		this.setButtonStyles(button);
		button.keepDownStateOnRollOut = true;
	}

	//-------------------------
	// PageIndicator
	//-------------------------

	function setPageIndicatorStyles(pageIndicator:PageIndicator) {
		pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
		pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
		pageIndicator.gap = this.smallGutterSize;
		pageIndicator.padding = this.smallGutterSize;
		pageIndicator.minTouchWidth = this.smallControlSize * 2;
		pageIndicator.minTouchHeight = this.smallControlSize * 2;
	}

	//-------------------------
	// Panel
	//-------------------------

	function setPanelStyles(panel:Panel) {
		this.setScrollerStyles(panel);

		var backgroundSkin = new Image(this.backgroundLightBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		panel.backgroundSkin = backgroundSkin;
		panel.padding = this.smallGutterSize;
		panel.outerPadding = this.borderSize;
	}

	function setPopUpHeaderStyles(header:Header) {
		header.padding = this.smallGutterSize;
		header.gap = this.smallGutterSize;
		header.titleGap = this.smallGutterSize;

		header.fontStyles = this.xlargeLightUIFontStyles.clone();
		header.disabledFontStyles = this.xlargeLightUIDisabledFontStyles.clone();

		var backgroundSkin = new ImageSkin(this.popUpHeaderBackgroundSkinTexture);
		backgroundSkin.tileGrid = new Rectangle();
		backgroundSkin.width = this.gridSize;
		backgroundSkin.height = this.gridSize;
		backgroundSkin.minWidth = this.gridSize;
		backgroundSkin.minHeight = this.gridSize;
		header.backgroundSkin = backgroundSkin;
	}

	//-------------------------
	// PanelScreen
	//-------------------------

	function setPanelScreenStyles(screen:PanelScreen) {
		this.setScrollerStyles(screen);
	}

	function setPanelScreenHeaderStyles(header:Header) {
		this.setHeaderStyles(header);
		header.useExtraPaddingForOSStatusBar = true;
	}

	//-------------------------
	// PickerList
	//-------------------------

	function setPickerListStyles(list:PickerList) {
		if (DeviceCapabilities.isPhone(this.starling.nativeStage)) {
			list.listFactory = pickerListSpinnerListFactory;
			list.popUpContentManager = new BottomDrawerPopUpContentManager();
		} else // tablet or desktop
		{
			list.popUpContentManager = new CalloutPopUpContentManager();
			list.customItemRendererStyleName = THEME_STYLE_NAME_TABLET_PICKER_LIST_ITEM_RENDERER;
		}
	}

	function setPickerListPopUpListStyles(list:List) {
		this.setDropDownListStyles(list);
	}

	function setPickerListItemRendererStyles(itemRenderer:BaseDefaultItemRenderer) {
		var skin = new ImageSkin(this.itemRendererUpSkinTexture);
		skin.setTextureForState(ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
		skin.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
		skin.width = this.popUpFillSize;
		skin.height = this.gridSize;
		skin.minWidth = this.popUpFillSize;
		skin.minHeight = this.gridSize;
		itemRenderer.defaultSkin = skin;

		var defaultSelectedIcon = new ImageLoader();
		defaultSelectedIcon.source = this.pickerListItemSelectedIconTexture;
		itemRenderer.defaultSelectedIcon = defaultSelectedIcon;
		defaultSelectedIcon.validate();

		var defaultIcon = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
		defaultIcon.alpha = 0;
		itemRenderer.defaultIcon = defaultIcon;

		itemRenderer.fontStyles = this.largeLightFontStyles.clone();
		itemRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();
		itemRenderer.setFontStylesForState(ButtonState.DOWN, this.largeDarkFontStyles.clone());

		itemRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.setIconLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();
		itemRenderer.setAccessoryLabelFontStylesForState(ButtonState.DOWN, this.darkFontStyles.clone());

		itemRenderer.itemHasIcon = false;
		itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
		itemRenderer.paddingTop = this.smallGutterSize;
		itemRenderer.paddingBottom = this.smallGutterSize;
		itemRenderer.paddingLeft = this.gutterSize;
		itemRenderer.paddingRight = this.gutterSize;
		itemRenderer.gap = ASCompat.MAX_FLOAT;
		itemRenderer.minGap = this.gutterSize;
		itemRenderer.iconPosition = RelativePosition.RIGHT;
		itemRenderer.accessoryGap = this.smallGutterSize;
		itemRenderer.minAccessoryGap = this.smallGutterSize;
		itemRenderer.accessoryPosition = RelativePosition.BOTTOM;
		itemRenderer.layoutOrder = ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON;
		itemRenderer.minTouchWidth = this.gridSize;
		itemRenderer.minTouchHeight = this.gridSize;
	}

	function setPickerListButtonStyles(button:Button) {
		this.setButtonStyles(button);

		var icon = new ImageSkin(this.pickerListButtonIconTexture);
		icon.selectedTexture = this.pickerListButtonSelectedIconTexture;
		icon.setTextureForState(ButtonState.DISABLED, this.pickerListButtonIconDisabledTexture);
		button.defaultIcon = icon;

		button.gap = ASCompat.MAX_FLOAT;
		button.minGap = this.gutterSize;
		button.iconPosition = RelativePosition.RIGHT;
	}

	//-------------------------
	// ProgressBar
	//-------------------------

	function setProgressBarStyles(progress:ProgressBar) {
		var backgroundSkin = new Image(this.backgroundSkinTexture);
		backgroundSkin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		if (progress.direction == Direction.VERTICAL) {
			backgroundSkin.width = this.smallControlSize;
			backgroundSkin.height = this.wideControlSize;
		} else {
			backgroundSkin.width = this.wideControlSize;
			backgroundSkin.height = this.smallControlSize;
		}
		progress.backgroundSkin = backgroundSkin;

		var backgroundDisabledSkin = new Image(this.backgroundDisabledSkinTexture);
		backgroundDisabledSkin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		if (progress.direction == Direction.VERTICAL) {
			backgroundDisabledSkin.width = this.smallControlSize;
			backgroundDisabledSkin.height = this.wideControlSize;
		} else {
			backgroundDisabledSkin.width = this.wideControlSize;
			backgroundDisabledSkin.height = this.smallControlSize;
		}
		progress.backgroundDisabledSkin = backgroundDisabledSkin;

		var fillSkin = new Image(this.buttonUpSkinTexture);
		fillSkin.scale9Grid = BUTTON_SCALE9_GRID;
		fillSkin.width = this.smallControlSize;
		fillSkin.height = this.smallControlSize;
		progress.fillSkin = fillSkin;

		var fillDisabledSkin = new Image(this.buttonDisabledSkinTexture);
		fillDisabledSkin.scale9Grid = BUTTON_SCALE9_GRID;
		fillDisabledSkin.width = this.smallControlSize;
		fillDisabledSkin.height = this.smallControlSize;
		progress.fillDisabledSkin = fillDisabledSkin;
	}

	//-------------------------
	// Radio
	//-------------------------

	function setRadioStyles(radio:Radio) {
		var skin = new Quad(this.controlSize, this.controlSize);
		skin.alpha = 0;
		radio.defaultSkin = skin;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		radio.focusIndicatorSkin = focusIndicatorSkin;
		radio.focusPadding = this.focusPaddingSize;

		var icon = new ImageSkin(this.radioUpIconTexture);
		icon.selectedTexture = this.radioSelectedUpIconTexture;
		icon.setTextureForState(ButtonState.DOWN, this.radioDownIconTexture);
		icon.setTextureForState(ButtonState.DISABLED, this.radioDisabledIconTexture);
		icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.radioSelectedDownIconTexture);
		icon.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.radioSelectedDisabledIconTexture);
		radio.defaultIcon = icon;

		radio.fontStyles = this.lightUIFontStyles.clone();
		radio.disabledFontStyles = this.lightDisabledUIFontStyles.clone();

		radio.horizontalAlign = HorizontalAlign.LEFT;
		radio.gap = this.smallControlGutterSize;
		radio.minGap = this.smallControlGutterSize;
		radio.minTouchWidth = this.gridSize;
		radio.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// ScrollContainer
	//-------------------------

	function setScrollContainerStyles(container:ScrollContainer) {
		this.setScrollerStyles(container);
	}

	function setToolbarScrollContainerStyles(container:ScrollContainer) {
		this.setScrollerStyles(container);
		if (container.layout == null) {
			var layout = new HorizontalLayout();
			layout.padding = this.smallGutterSize;
			layout.gap = this.smallGutterSize;
			layout.verticalAlign = VerticalAlign.MIDDLE;
			container.layout = layout;
		}

		var backgroundSkin = new ImageSkin(this.headerBackgroundSkinTexture);
		backgroundSkin.tileGrid = new Rectangle();
		backgroundSkin.width = this.gridSize;
		backgroundSkin.height = this.gridSize;
		backgroundSkin.minWidth = this.gridSize;
		backgroundSkin.minHeight = this.gridSize;
		container.backgroundSkin = backgroundSkin;
	}

	//-------------------------
	// ScrollScreen
	//-------------------------

	function setScrollScreenStyles(screen:ScrollScreen) {
		this.setScrollerStyles(screen);
	}

	//-------------------------
	// ScrollText
	//-------------------------

	function setScrollTextStyles(text:ScrollText) {
		this.setScrollerStyles(text);

		text.fontStyles = this.lightScrollTextFontStyles.clone();
		text.disabledFontStyles = this.lightDisabledScrollTextFontStyles.clone();

		text.padding = this.gutterSize;
		text.paddingRight = this.gutterSize + this.smallGutterSize;
	}

	//-------------------------
	// SimpleScrollBar
	//-------------------------

	function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar) {
		if (scrollBar.direction == Direction.HORIZONTAL) {
			scrollBar.paddingRight = this.scrollBarGutterSize;
			scrollBar.paddingBottom = this.scrollBarGutterSize;
			scrollBar.paddingLeft = this.scrollBarGutterSize;
			scrollBar.customThumbStyleName = THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
		} else {
			scrollBar.paddingTop = this.scrollBarGutterSize;
			scrollBar.paddingRight = this.scrollBarGutterSize;
			scrollBar.paddingBottom = this.scrollBarGutterSize;
			scrollBar.customThumbStyleName = THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
		}
	}

	function setHorizontalSimpleScrollBarThumbStyles(thumb:Button) {
		var defaultSkin = new Image(this.horizontalScrollBarThumbSkinTexture);
		defaultSkin.scale9Grid = HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID;
		defaultSkin.width = this.gutterSize;
		thumb.defaultSkin = defaultSkin;
		thumb.hasLabelTextRenderer = false;
	}

	function setVerticalSimpleScrollBarThumbStyles(thumb:Button) {
		var defaultSkin = new Image(this.verticalScrollBarThumbSkinTexture);
		defaultSkin.scale9Grid = VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID;
		defaultSkin.height = this.gutterSize;
		thumb.defaultSkin = defaultSkin;
		thumb.hasLabelTextRenderer = false;
	}

	//-------------------------
	// Slider
	//-------------------------

	function setSliderStyles(slider:Slider) {
		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		slider.focusIndicatorSkin = focusIndicatorSkin;
		slider.focusPadding = this.focusPaddingSize;

		slider.trackLayoutMode = TrackLayoutMode.SPLIT;
		if (slider.direction == Direction.VERTICAL) {
			slider.customMinimumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
			slider.customMaximumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
		} else // horizontal
		{
			slider.customMinimumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
			slider.customMaximumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
		}
	}

	function setHorizontalSliderMinimumTrackStyles(track:Button) {
		var skin = new ImageSkin(this.backgroundSkinTexture);
		skin.disabledTexture = this.backgroundDisabledSkinTexture;
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.wideControlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.wideControlSize;
		skin.minHeight = this.controlSize;
		track.defaultSkin = skin;

		track.hasLabelTextRenderer = false;
	}

	function setHorizontalSliderMaximumTrackStyles(track:Button) {
		var skin = new ImageSkin(this.backgroundSkinTexture);
		skin.disabledTexture = this.backgroundDisabledSkinTexture;
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.wideControlSize;
		skin.minWidth = this.wideControlSize;
		skin.height = this.controlSize;
		skin.minHeight = this.controlSize;
		track.defaultSkin = skin;

		track.hasLabelTextRenderer = false;
	}

	function setVerticalSliderMinimumTrackStyles(track:Button) {
		var skin = new ImageSkin(this.backgroundSkinTexture);
		skin.disabledTexture = this.backgroundDisabledSkinTexture;
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.wideControlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.wideControlSize;
		track.defaultSkin = skin;

		track.hasLabelTextRenderer = false;
	}

	function setVerticalSliderMaximumTrackStyles(track:Button) {
		var skin = new ImageSkin(this.backgroundSkinTexture);
		skin.disabledTexture = this.backgroundDisabledSkinTexture;
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.controlSize;
		skin.height = this.wideControlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.wideControlSize;
		track.defaultSkin = skin;

		track.hasLabelTextRenderer = false;
	}

	//-------------------------
	// SpinnerList
	//-------------------------

	function setSpinnerListStyles(list:SpinnerList) {
		this.setScrollerStyles(list);

		var backgroundSkin = new Image(this.backgroundDarkBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		list.backgroundSkin = backgroundSkin;

		var selectionOverlaySkin = new Image(this.spinnerListSelectionOverlaySkinTexture);
		selectionOverlaySkin.scale9Grid = SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID;
		list.selectionOverlaySkin = selectionOverlaySkin;

		list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;

		list.paddingTop = this.borderSize;
		list.paddingBottom = this.borderSize;
	}

	function setSpinnerListItemRendererStyles(itemRenderer:DefaultListItemRenderer) {
		var defaultSkin = new Quad(this.gridSize, this.gridSize, 0xff00ff);
		defaultSkin.alpha = 0;
		itemRenderer.defaultSkin = defaultSkin;

		itemRenderer.fontStyles = this.largeLightFontStyles.clone();
		itemRenderer.disabledFontStyles = this.largeLightDisabledFontStyles.clone();

		itemRenderer.iconLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.iconLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();

		itemRenderer.accessoryLabelFontStyles = this.lightFontStyles.clone();
		itemRenderer.accessoryLabelDisabledFontStyles = this.lightDisabledFontStyles.clone();

		itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
		itemRenderer.paddingTop = this.smallGutterSize;
		itemRenderer.paddingBottom = this.smallGutterSize;
		itemRenderer.paddingLeft = this.gutterSize;
		itemRenderer.paddingRight = this.gutterSize;
		itemRenderer.gap = this.gutterSize;
		itemRenderer.minGap = this.gutterSize;
		itemRenderer.iconPosition = RelativePosition.LEFT;
		itemRenderer.accessoryGap = ASCompat.MAX_FLOAT;
		itemRenderer.minAccessoryGap = this.gutterSize;
		itemRenderer.accessoryPosition = RelativePosition.RIGHT;
		itemRenderer.minTouchWidth = this.gridSize;
		itemRenderer.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// TabBar
	//-------------------------

	function setTabBarStyles(tabBar:TabBar) {
		tabBar.distributeTabSizes = true;
	}

	function setTabStyles(tab:ToggleButton) {
		var skin = new ImageSkin(this.tabUpSkinTexture);
		skin.selectedTexture = this.tabSelectedUpSkinTexture;
		skin.setTextureForState(ButtonState.DOWN, this.tabDownSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED, this.tabDisabledSkinTexture);
		skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.tabSelectedDisabledSkinTexture);
		skin.scale9Grid = TAB_SCALE9_GRID;
		skin.width = this.gridSize;
		skin.height = this.gridSize;
		skin.minWidth = this.gridSize;
		skin.minHeight = this.gridSize;
		tab.defaultSkin = skin;

		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		tab.focusIndicatorSkin = focusIndicatorSkin;
		tab.focusPadding = this.tabFocusPaddingSize;

		tab.fontStyles = this.lightUIFontStyles.clone();
		tab.disabledFontStyles = this.lightDisabledUIFontStyles.clone();
		tab.selectedFontStyles = this.darkUIFontStyles.clone();

		tab.paddingTop = this.smallGutterSize;
		tab.paddingBottom = this.smallGutterSize;
		tab.paddingLeft = this.gutterSize;
		tab.paddingRight = this.gutterSize;
		tab.gap = this.smallGutterSize;
		tab.minGap = this.smallGutterSize;
		tab.minTouchWidth = this.gridSize;
		tab.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// TextArea
	//-------------------------

	function setTextAreaStyles(textArea:TextArea) {
		this.setScrollerStyles(textArea);

		var skin = new ImageSkin(this.backgroundInsetSkinTexture);
		skin.setTextureForState(TextInputState.DISABLED, this.backgroundDisabledSkinTexture);
		skin.setTextureForState(TextInputState.FOCUSED, this.backgroundInsetFocusedSkinTexture);
		skin.setTextureForState(TextInputState.ERROR, this.backgroundInsetDangerSkinTexture);
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.wideControlSize;
		skin.height = this.wideControlSize;
		textArea.backgroundSkin = skin;

		textArea.fontStyles = this.lightInputFontStyles.clone();
		textArea.disabledFontStyles = this.lightDisabledInputFontStyles.clone();

		textArea.promptFontStyles = this.lightFontStyles.clone();
		textArea.promptDisabledFontStyles = this.lightDisabledFontStyles.clone();

		textArea.textEditorFactory = textAreaTextEditorFactory;

		textArea.innerPadding = this.smallGutterSize;
	}

	function setTextAreaErrorCalloutStyles(callout:TextCallout) {
		this.setDangerCalloutStyles(callout);

		callout.fontStyles = this.lightFontStyles.clone();
		callout.disabledFontStyles = this.lightDisabledFontStyles.clone();

		callout.horizontalAlign = HorizontalAlign.LEFT;
		callout.verticalAlign = VerticalAlign.TOP;
	}

	//-------------------------
	// TextCallout
	//-------------------------

	function setTextCalloutStyles(callout:TextCallout) {
		this.setCalloutStyles(callout);

		callout.fontStyles = this.lightFontStyles.clone();
		callout.disabledFontStyles = this.lightDisabledFontStyles.clone();
	}

	//-------------------------
	// Toast
	//-------------------------

	function setToastStyles(toast:Toast) {
		var backgroundSkin = new Image(this.backgroundLightBorderSkinTexture);
		backgroundSkin.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
		toast.backgroundSkin = backgroundSkin;

		toast.fontStyles = this.lightFontStyles.clone();

		toast.width = this.popUpFillSize;
		toast.paddingTop = this.gutterSize;
		toast.paddingRight = this.gutterSize;
		toast.paddingBottom = this.gutterSize;
		toast.paddingLeft = this.gutterSize;
		toast.gap = ASCompat.MAX_FLOAT;
		toast.minGap = this.smallGutterSize;
		toast.horizontalAlign = HorizontalAlign.LEFT;
		toast.verticalAlign = VerticalAlign.MIDDLE;
	}

	function setToastActionsStyles(group:ButtonGroup) {
		group.direction = Direction.HORIZONTAL;
		group.gap = this.smallGutterSize;
		group.customButtonStyleName = THEME_STYLE_NAME_TOAST_ACTIONS_BUTTON;
	}

	function setToastActionsButtonStyles(button:Button) {
		button.fontStyles = this.selectedUIFontStyles.clone();
		button.setFontStylesForState(ButtonState.DOWN, this.lightUIFontStyles);
	}

	//-------------------------
	// TextInput
	//-------------------------

	function setBaseTextInputStyles(input:TextInput) {
		var skin = new ImageSkin(this.backgroundInsetSkinTexture);
		skin.setTextureForState(TextInputState.DISABLED, this.backgroundInsetDisabledSkinTexture);
		skin.setTextureForState(TextInputState.FOCUSED, this.backgroundInsetFocusedSkinTexture);
		skin.setTextureForState(TextInputState.ERROR, this.backgroundInsetDangerSkinTexture);
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = this.wideControlSize;
		skin.height = this.controlSize;
		skin.minWidth = this.controlSize;
		skin.minHeight = this.controlSize;
		input.backgroundSkin = skin;

		input.fontStyles = this.lightInputFontStyles.clone();
		input.disabledFontStyles = this.lightDisabledInputFontStyles.clone();

		input.promptFontStyles = this.lightFontStyles.clone();
		input.promptDisabledFontStyles = this.lightDisabledFontStyles.clone();

		input.minTouchWidth = this.gridSize;
		input.minTouchHeight = this.gridSize;
		input.gap = this.smallControlGutterSize;
		input.paddingTop = this.smallControlGutterSize;
		input.paddingRight = this.smallGutterSize;
		input.paddingBottom = this.smallControlGutterSize;
		input.paddingLeft = this.smallGutterSize;
		input.verticalAlign = VerticalAlign.MIDDLE;
	}

	function setTextInputStyles(input:TextInput) {
		this.setBaseTextInputStyles(input);
	}

	function setTextInputErrorCalloutStyles(callout:TextCallout) {
		this.setDangerCalloutStyles(callout);

		callout.fontStyles = this.lightFontStyles.clone();
		callout.disabledFontStyles = this.lightDisabledFontStyles.clone();

		callout.horizontalAlign = HorizontalAlign.LEFT;
		callout.verticalAlign = VerticalAlign.TOP;
	}

	function setSearchTextInputStyles(input:TextInput) {
		this.setBaseTextInputStyles(input);

		input.fontStyles = this.lightInputFontStyles.clone();
		input.disabledFontStyles = this.lightDisabledInputFontStyles.clone();

		input.promptFontStyles = this.lightFontStyles.clone();
		input.promptDisabledFontStyles = this.lightDisabledFontStyles.clone();

		var icon = new ImageSkin(this.searchIconTexture);
		icon.setTextureForState(TextInputState.DISABLED, this.searchIconDisabledTexture);
		input.defaultIcon = icon;
	}

	//-------------------------
	// ToggleSwitch
	//-------------------------

	function setToggleSwitchStyles(toggle:ToggleSwitch) {
		var focusIndicatorSkin = new Image(this.focusIndicatorSkinTexture);
		focusIndicatorSkin.scale9Grid = FOCUS_INDICATOR_SCALE_9_GRID;
		toggle.focusIndicatorSkin = focusIndicatorSkin;
		toggle.focusPadding = this.focusPaddingSize;

		toggle.trackLayoutMode = TrackLayoutMode.SINGLE;

		toggle.offLabelFontStyles = this.lightUIFontStyles.clone();
		toggle.offLabelDisabledFontStyles = this.lightDisabledUIFontStyles.clone();
		toggle.onLabelFontStyles = this.selectedUIFontStyles.clone();
		toggle.onLabelDisabledFontStyles = this.lightDisabledUIFontStyles.clone();
	}

	// see Shared section for thumb styles

	function setToggleSwitchTrackStyles(track:Button) {
		var skin = new ImageSkin(this.backgroundSkinTexture);
		skin.disabledTexture = this.backgroundDisabledSkinTexture;
		skin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		skin.width = Math.fround(this.controlSize * 2.5);
		skin.height = this.controlSize;
		track.defaultSkin = skin;
		track.hasLabelTextRenderer = false;
	}

	//-------------------------
	// Tree
	//-------------------------

	function setTreeStyles(tree:Tree) {
		this.setScrollerStyles(tree);
		var backgroundSkin = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
		tree.backgroundSkin = backgroundSkin;
	}

	function setTreeItemRendererStyles(itemRenderer:DefaultTreeItemRenderer) {
		this.setItemRendererStyles(itemRenderer);

		itemRenderer.indentation = this.treeDisclosureOpenIconTexture.width;

		var disclosureOpenIcon = new ImageSkin(this.treeDisclosureOpenIconTexture);
		disclosureOpenIcon.selectedTexture = this.treeDisclosureOpenSelectedIconTexture;
		// make sure the hit area is large enough for touch screens
		disclosureOpenIcon.minTouchWidth = this.gridSize;
		disclosureOpenIcon.minTouchHeight = this.gridSize;
		itemRenderer.disclosureOpenIcon = disclosureOpenIcon;

		var disclosureClosedIcon = new ImageSkin(this.treeDisclosureClosedIconTexture);
		disclosureClosedIcon.selectedTexture = this.treeDisclosureClosedSelectedIconTexture;
		disclosureClosedIcon.minTouchWidth = this.gridSize;
		disclosureClosedIcon.minTouchHeight = this.gridSize;
		itemRenderer.disclosureClosedIcon = disclosureClosedIcon;
	}

	//-------------------------
	// PlayPauseToggleButton
	//-------------------------

	function setPlayPauseToggleButtonStyles(button:PlayPauseToggleButton) {
		var skin = new Quad(this.controlSize, this.controlSize);
		skin.alpha = 0;
		button.defaultSkin = skin;

		var icon = new ImageSkin(this.playPauseButtonPlayUpIconTexture);
		icon.selectedTexture = this.playPauseButtonPauseUpIconTexture;
		icon.setTextureForState(ButtonState.DOWN, this.playPauseButtonPlayDownIconTexture);
		icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.playPauseButtonPauseDownIconTexture);
		button.defaultIcon = icon;

		button.hasLabelTextRenderer = false;

		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	function setOverlayPlayPauseToggleButtonStyles(button:PlayPauseToggleButton) {
		var icon = new ImageSkin(null);
		icon.setTextureForState(ButtonState.UP, this.overlayPlayPauseButtonPlayUpIconTexture);
		icon.setTextureForState(ButtonState.HOVER, this.overlayPlayPauseButtonPlayUpIconTexture);
		icon.setTextureForState(ButtonState.DOWN, this.overlayPlayPauseButtonPlayDownIconTexture);
		button.defaultIcon = icon;

		button.hasLabelTextRenderer = false;

		var overlaySkin = new Quad(1, 1, VIDEO_OVERLAY_COLOR);
		overlaySkin.alpha = VIDEO_OVERLAY_ALPHA;
		button.upSkin = overlaySkin;
		button.hoverSkin = overlaySkin;
	}

	//-------------------------
	// FullScreenToggleButton
	//-------------------------

	function setFullScreenToggleButtonStyles(button:FullScreenToggleButton) {
		var skin = new Quad(this.controlSize, this.controlSize);
		skin.alpha = 0;
		button.defaultSkin = skin;

		var icon = new ImageSkin(this.fullScreenToggleButtonEnterUpIconTexture);
		icon.selectedTexture = this.fullScreenToggleButtonExitUpIconTexture;
		icon.setTextureForState(ButtonState.DOWN, this.fullScreenToggleButtonEnterDownIconTexture);
		icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.fullScreenToggleButtonExitDownIconTexture);
		button.defaultIcon = icon;

		button.hasLabelTextRenderer = false;

		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// MuteToggleButton
	//-------------------------

	function setMuteToggleButtonStyles(button:MuteToggleButton) {
		var skin = new Quad(this.controlSize, this.controlSize);
		skin.alpha = 0;
		button.defaultSkin = skin;

		var icon = new ImageSkin(this.muteToggleButtonLoudUpIconTexture);
		icon.selectedTexture = this.muteToggleButtonMutedUpIconTexture;
		icon.setTextureForState(ButtonState.DOWN, this.muteToggleButtonLoudDownIconTexture);
		icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.muteToggleButtonMutedDownIconTexture);
		button.defaultIcon = icon;

		button.hasLabelTextRenderer = false;
		button.showVolumeSliderOnHover = false;

		button.minTouchWidth = this.gridSize;
		button.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// SeekSlider
	//-------------------------

	function setSeekSliderStyles(slider:SeekSlider) {
		slider.trackLayoutMode = TrackLayoutMode.SPLIT;
		slider.showThumb = false;
		var progressSkin = new Image(this.seekSliderProgressSkinTexture);
		progressSkin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		progressSkin.width = this.smallControlSize;
		progressSkin.height = this.smallControlSize;
		slider.progressSkin = progressSkin;
	}

	function setSeekSliderThumbStyles(thumb:Button) {
		var thumbSize:Float = 6;
		thumb.defaultSkin = new Quad(thumbSize, thumbSize);
		thumb.hasLabelTextRenderer = false;
		thumb.minTouchWidth = this.gridSize;
		thumb.minTouchHeight = this.gridSize;
	}

	function setSeekSliderMinimumTrackStyles(track:Button) {
		var defaultSkin = new ImageSkin(this.buttonUpSkinTexture);
		defaultSkin.scale9Grid = BUTTON_SCALE9_GRID;
		defaultSkin.width = this.wideControlSize;
		defaultSkin.height = this.smallControlSize;
		defaultSkin.minWidth = this.wideControlSize;
		defaultSkin.minHeight = this.smallControlSize;
		track.defaultSkin = defaultSkin;
		track.hasLabelTextRenderer = false;
		track.minTouchHeight = this.gridSize;
	}

	function setSeekSliderMaximumTrackStyles(track:Button) {
		var defaultSkin = new ImageSkin(this.backgroundSkinTexture);
		defaultSkin.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
		defaultSkin.width = this.wideControlSize;
		defaultSkin.height = this.smallControlSize;
		defaultSkin.minHeight = this.smallControlSize;
		track.defaultSkin = defaultSkin;
		track.hasLabelTextRenderer = false;
		track.minTouchHeight = this.gridSize;
	}

	//-------------------------
	// VolumeSlider
	//-------------------------

	function setVolumeSliderStyles(slider:VolumeSlider) {
		slider.direction = Direction.HORIZONTAL;
		slider.trackLayoutMode = TrackLayoutMode.SPLIT;
		slider.showThumb = false;
	}

	function setVolumeSliderThumbStyles(thumb:Button) {
		var thumbSize:Float = 6;
		var defaultSkin = new Quad(thumbSize, thumbSize);
		defaultSkin.width = 0;
		defaultSkin.height = 0;
		thumb.defaultSkin = defaultSkin;
		thumb.hasLabelTextRenderer = false;
	}

	function setVolumeSliderMinimumTrackStyles(track:Button) {
		var defaultSkin = new ImageLoader();
		defaultSkin.scaleContent = false;
		defaultSkin.source = this.volumeSliderMinimumTrackSkinTexture;
		track.defaultSkin = defaultSkin;
		track.hasLabelTextRenderer = false;
		track.minTouchHeight = this.gridSize;
	}

	function setVolumeSliderMaximumTrackStyles(track:Button) {
		var defaultSkin = new ImageLoader();
		defaultSkin.scaleContent = false;
		defaultSkin.horizontalAlign = HorizontalAlign.RIGHT;
		defaultSkin.source = this.volumeSliderMaximumTrackSkinTexture;
		track.defaultSkin = defaultSkin;
		track.hasLabelTextRenderer = false;
		track.minTouchHeight = this.gridSize;
	}
}
