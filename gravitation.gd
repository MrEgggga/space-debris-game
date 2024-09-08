extends Node

var GM := 10000000000000.0
#var GM := 0.0
var EARTH_RADIUS := 300000.0

# simulate universal gravitation and centrifugal force in funky coordinate space
func get_radial_accel(tan_vel: float, altitude: float) -> float:
	var rad := altitude + EARTH_RADIUS
	return (tan_vel * tan_vel) / rad - GM / (rad * rad)

# find orbital velocity
func get_orbit_velocity(altitude: float) -> float:
	var rad := altitude + EARTH_RADIUS
	return sqrt(GM / rad)
