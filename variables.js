.pragma library
var nowStop = 0;
var speedUp = 0;
var lastSpeed = 0;
var currentSpeed = 0;
var lastTime = 0;
var maxSpeed = 0;
var from0to50 = 0;
var from0to100 = 0;
//var speed = 0;
var voltage = 0;
var time = 0;

var trip1 = 0;          // Total
var trip2 = 0;          // Remaining
var trip3 = 0;          // Today
var lowRPM  = 2         // Green RPM zone
var maxRPM  = 5.7;      // Red RPM zone
var lowSpd  = 30;       // Green Speed zone
var maxSpd  = 110;      // Red Speed zone
var lowTemp = 60;       // Green Temperature zone
var maxTemp = 96;       // Red Temperature zone
var lowFuel = 10        // Red Fuel zone
var lowBatt = 11.5      // Red Battery zone
