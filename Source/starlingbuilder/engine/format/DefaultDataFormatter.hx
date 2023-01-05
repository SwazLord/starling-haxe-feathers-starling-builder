/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */

package starlingbuilder.engine.format;

import haxe.Json;

/**
 * @private
 */
class DefaultDataFormatter implements IDataFormatter {
	private var _prettyData:Bool = true;

	public var prettyData(get, set):Bool;

	public function get_prettyData():Bool {
		return this._prettyData;
	}

	public function set_prettyData(value:Bool):Bool {
		return this._prettyData = value;
	}

	public function new() {}

	public function read(data:Dynamic):Dynamic {
		if (Std.isOfType(data, String)) {
			return cast(Json.parse(data), String);
		} else {
			return data;
		}
	}
}
