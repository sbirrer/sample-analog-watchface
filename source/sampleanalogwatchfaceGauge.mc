using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;
using Toybox.System as Sys;

class Gauge extends Ui.Drawable {

	function initialize(params) {
		Drawable.initialize(params);
	}

	function draw(dc) {
		// Set the background color then call to clear the screen
		dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		var radius = (width > height ? height : width) / 2; 
		
		dc.drawCircle(locX+radius, locY+radius, radius);
	}

}
