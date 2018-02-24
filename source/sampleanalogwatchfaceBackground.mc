using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;
using Toybox.System as Sys;

class Background extends Ui.Drawable {
	
	function initialize(params) {
		Drawable.initialize(params);
	}

	function draw(dc) {
		// Set the background color then call to clear the screen
		dc.setColor(Gfx.COLOR_LT_GRAY, App.getApp().getProperty("BackgroundColor"));
		dc.clear();
		
		var center = [dc.getWidth() / 2, dc.getHeight() / 2];
		var shortInnerHashRadius = dc.getWidth() / 2 - 5;
		var longInnerHashRadius = dc.getWidth() / 2 - 10;
		var outerHashRadius = dc.getWidth() / 2;

		for (var min = 0; min < 60; min++) {
			var innerHashRadius = shortInnerHashRadius;
			var penWidth = 1;
			
			if (min % 5 == 0) {
				innerHashRadius = longInnerHashRadius;
				penWidth = 3;
			}
			
			var hash = 
				[
					[
						innerHashRadius * Math.cos(min*Math.PI/30) + center[0], 
						innerHashRadius * Math.sin(min*Math.PI/30) + center[1]
					], 
					[
						outerHashRadius * Math.cos(min*Math.PI/30) + center[0], 
						outerHashRadius * Math.sin(min*Math.PI/30) + center[1]
					]
				];
			
			dc.setColor(Gfx.COLOR_LT_GRAY, App.getApp().getProperty("BackgroundColor"));
			dc.setPenWidth(penWidth);
			dc.drawLine(hash[0][0], hash[0][1], hash[1][0], hash[1][1]);
			
			if (min % 5 == 0) {
				dc.setPenWidth(1);
				dc.setColor(Gfx.COLOR_WHITE, App.getApp().getProperty("BackgroundColor"));
				dc.drawLine(hash[0][0], hash[0][1], hash[1][0], hash[1][1]);
			}
		}
	}

}
