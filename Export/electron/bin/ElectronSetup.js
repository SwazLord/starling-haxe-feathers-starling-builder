(function ($global) { "use strict";
var ElectronSetup = function() { };
ElectronSetup.main = function() {
	ElectronApp.commandLine.appendSwitch("ignore-gpu-blacklist","true");
	var windows = [{ allowHighDPI : true, alwaysOnTop : false, antialiasing : 0, background : 16777215, borderless : false, colorDepth : 32, depthBuffer : true, display : 0, fullscreen : false, hardware : true, height : 0, hidden : false, maximized : false, minimized : false, parameters : { }, resizable : true, stencilBuffer : true, title : "StarlingProject", vsync : false, width : 0, x : null, y : null}];
	var _g = 0;
	var _g1 = windows.length;
	while(_g < _g1) {
		var i = _g++;
		var $window = [windows[i]];
		var width = [$window[0].width];
		var height = [$window[0].height];
		if(width[0] == 0) {
			width[0] = 800;
		}
		if(height[0] == 0) {
			height[0] = 600;
		}
		var frame = [$window[0].borderless == false];
		ElectronApp.commandLine.appendSwitch("--autoplay-policy","no-user-gesture-required");
		ElectronApp.on("ready",(function(frame,height,width,$window) {
			return function(e) {
				var config = { webPreferences : { nodeIntegration : true}, fullscreen : $window[0].fullscreen, frame : frame[0], resizable : $window[0].resizable, alwaysOnTop : $window[0].alwaysOnTop, width : width[0], height : height[0], webgl : $window[0].hardware};
				ElectronSetup.window = new ElectronBrowserWindow(config);
				ElectronSetup.window.on("closed",(function() {
					return function() {
						if(process.platform != "darwin") {
							ElectronApp.quit();
						}
					};
				})());
				ElectronSetup.window.loadURL("file://" + __dirname + "/index.html");
				ElectronSetup.window.webContents.openDevTools();
			};
		})(frame,height,width,$window));
	}
};
var ElectronApp = require("electron").app;
var ElectronBrowserWindow = require("electron").BrowserWindow;
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
ElectronSetup.main();
})({});

//# sourceMappingURL=ElectronSetup.js.map