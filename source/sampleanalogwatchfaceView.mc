using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class sampleanalogwatchfaceView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

	// Returns the point coordinates for the hours hand with respect to
	// the 12 o'clock position. 
	function getHourHandCoords(dc) {
		var result = new [6];
		
		switch (dc.getHeight()) {
			case 240: 
				result[0] = [  0,   4];
				result[1] = [ -4,   0];
				result[2] = [ -2, -68];
				result[3] = [  0, -70];
				result[4] = [  2, -65];
				result[5] = [  4,   0];
				break;
			case 218:
				result[0] = [ 0,   4];
				result[1] = [-4,   0];
				result[2] = [-2, -63];
				result[3] = [ 0, -65];
				result[4] = [ 2, -63];
				result[5] = [ 4,   0];
		}
				
		return result;
	}
	
	function getMinuteHandCoords(dc) {
		var result = new [6];
		
		switch (dc.getHeight()) {
			case 240:
				result[0] = [  0,    4];
				result[1] = [ -4,    0];
				result[2] = [ -2, -108];
				result[3] = [  0, -110];
				result[4] = [  2, -108];
				result[5] = [  4,    0];
				break;
			case 218:
				result[0] = [ 0,    4];
				result[1] = [-4,    0];
				result[2] = [-2,  -98];
				result[3] = [ 0, -100];
				result[4] = [ 2,  -98];
				result[5] = [ 4,    0];
		}
				
		return result;
	}
	
	// Translates the given coordinates by a given vector. 
	function translateCoords(coords, vector) {
		var result = new [coords.size()];
		
		for (var i = 0; i < coords.size(); i++) {
			result[i] = [coords[i][0] + vector[0], coords[i][1] + vector[1]];
		}
		
		return result;
	}

	// Rotates the given coordinates around [0, 0] by a given angle in radian. 
	function rotateCoords(coords, angle) {
		var result = new [coords.size()];
		
		for (var i = 0; i < coords.size(); i++) {
			result[i] = [
				coords[i][0]*Math.cos(angle) - coords[i][1]*Math.sin(angle), 
				coords[i][0]*Math.sin(angle) + coords[i][1]*Math.cos(angle)
			];
		}
		
		return result;
	}

	function getHourAngle(clockTime) {
		return (clockTime.hour % 12)*Math.PI/6 + clockTime.min*Math.PI/360;
	}
	
	function getMinuteAngle(clockTime) {
		return clockTime.min*2*Math.PI/60;
	}

	// Update the view
	function onUpdate(dc) {
		// Get the current time and format it correctly
		var clockTime = Sys.getClockTime();

		var centerpoint = [dc.getWidth() / 2, dc.getHeight() / 2];
		
		View.onUpdate(dc);
		
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

		var hourHandCoords = getHourHandCoords(dc);
		var rotatedHourHandCoords = rotateCoords(hourHandCoords, getHourAngle(clockTime));
		var translatedRotatedHourHandCoords = translateCoords(rotatedHourHandCoords, centerpoint);

		var minuteHandCoords = getMinuteHandCoords(dc);
		var rotatedMinuteHandCoords = rotateCoords(minuteHandCoords, getMinuteAngle(clockTime));
		var translatedRotatedMinuteHandCoords = translateCoords(rotatedMinuteHandCoords, centerpoint);
		
		dc.fillPolygon(translatedRotatedHourHandCoords);
		dc.fillPolygon(translatedRotatedMinuteHandCoords);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
