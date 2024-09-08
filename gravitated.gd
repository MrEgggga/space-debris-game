## simulate universal gravitation in funky coordinates

extends RigidBody2D
class_name Gravitated

## can be set to 0 to disable universal gravitation
var gravitation_scale: float = 1

func _physics_process(delta: float) -> void:
	# use utility function to get acceleration due to gravity
	var accel := Gravitation.get_radial_accel(linear_velocity.x, -global_position.y)
	# apply force multiplied by scale & mass
	apply_central_force(Vector2.UP * accel * mass * gravitation_scale)
