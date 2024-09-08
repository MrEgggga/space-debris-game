extends Gravitated
class_name Debris


func _ready() -> void:
	# i would love to actually have the debris orbit at the correct velocity
	# but that has several problems -- for one it's way too fast to control
	linear_velocity.x = Gravitation.get_orbit_velocity(-global_position.y) / 50
	gravitation_scale = 0


func _on_body_entered(body: Node) -> void:
	# only attach to rocket
	if body is not Rocket:
		return
	
	# attach children (collision shape & sprite) to rocket
	for thing in [$node_2d, $collision_shape_2d]:
		var prev_pos = thing.global_position
		var prev_rot = thing.global_rotation
		remove_child(thing)
		body.add_child(thing)
		thing.global_position = prev_pos
		thing.global_rotation = prev_rot
	
	# update rocket's mass, center of mass, inertia -- 
	# the automatic calculations don't work here.
	# done according to various physics formulae
	body.center_of_mass = (
		(body.center_of_mass * body.mass / (body.mass + mass)) +
		(body.to_local(global_position) * mass / (body.mass + mass))
	)
	body.inertia += mass * body.to_local(global_position).length_squared()
	body.mass += mass
	
	# destroy the debris object which now has nothing
	queue_free()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# wrap around
	if position.x > 16384:
		position.x -= 32768
