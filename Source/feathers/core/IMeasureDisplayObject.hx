/*
Feathers
Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.core;
/**
	 * A display object with extra measurement properties.
	 *
	 * @productversion Feathers 3.0.0
	 */
interface IMeasureDisplayObject extends IFeathersDisplayObject {
    /**
		 * @copy feathers.core.FeathersControl#explicitWidth
		 */
         var explicitWidth(get, never):Float;
         function get_explicitWidth():Float;
         /**
		 * @copy feathers.core.FeathersControl#explicitMinWidth
		 */
         var explicitMinWidth(get, never):Float;
         function get_explicitMinWidth():Float;
         /**
		 * @copy feathers.core.FeathersControl#minWidth
		 */
         /**
		 * @private
		 */
		var minWidth(get, set):Float;
        /**
		 * @copy feathers.core.FeathersControl#explicitMaxWidth
		 */
		var explicitMaxWidth(get, never):Float;
        function get_explicitMaxWidth():Float;
        /**
		 * @copy feathers.core.FeathersControl#maxWidth
		 */
         /**
		 * @private
		 */
		var maxWidth(get, set):Float;
        /**
		 * @copy feathers.core.FeathersControl#explicitHeight
		 */
		var explicitHeight(get, never):Float;
        function get_explicitHeight():Float;
        /**
		 * @copy feathers.core.FeathersControl#explicitMinHeight
		 */
		var explicitMinHeight(get, never):Float;
        function get_explicitMinHeight():Float;
        /**
		 * @copy feathers.core.FeathersControl#minHeight
		 */
         /**
		 * @private
		 */
		var minHeight(get, set):Float;
        /**
		 * @copy feathers.core.FeathersControl#explicitMaxHeight
		 */
		var explicitMaxHeight(get, never):Float;
        function get_explicitMaxHeight():Float;
        /**
		 * @copy feathers.core.FeathersControl#maxHeight
		 */
         /**
		 * @private
		 */
		var maxHeight(get, set):Float;
}
