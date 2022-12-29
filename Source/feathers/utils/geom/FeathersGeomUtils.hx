/*
	Feathers
	Copyright 2012-2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.utils.geom;

import openfl.geom.Matrix;

class FeathersGeomUtils {
	/**
	 * Extracts the x scale value from a <code>flash.geom.Matrix</code>
	 *
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/geom/Matrix.html flash.geom.Matrix
	 *
	 * @productversion Feathers 1.2.0
	 */
	public static function matrixToScaleX(matrix:Matrix):Float {
		var a:Float = matrix.a;
		var b:Float = matrix.b;
		return Math.sqrt(a * a + b * b);
	}

	public static function matrixToScaleY(matrix:Matrix):Float {
		var c:Float = matrix.c;
		var d:Float = matrix.d;
		return Math.sqrt(c * c + d * d);
	}

	public static function matrixToRotation(matrix:Matrix):Float {
		var c:Float = matrix.c;
		var d:Float = matrix.d;
		return -Math.atan(c / d);
	}
}
