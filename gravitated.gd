extends RigidBody2D
class_name Gravitated

var gravitation_scale: float = 1

func _physics_process(delta: float) -> void:
	var accel := Gravitation.get_radial_accel(linear_velocity.x, -global_position.y)
	apply_central_force(Vector2.UP * accel * mass * gravitation_scale)
