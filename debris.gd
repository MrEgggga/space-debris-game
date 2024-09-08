extends Gravitated
class_name Debris


func _ready() -> void:
	linear_velocity.x = Gravitation.get_orbit_velocity(-global_position.y) / 50
	gravitation_scale = 0


func _on_body_entered(body: Node) -> void:
	if body is StaticBody2D:
		return
	
	print_debug("hi")
	
	var pin_joint_1 := PinJoint2D.new()
	pin_joint_1.position = Vector2(-20, -20)
	pin_joint_1.node_a = get_path()
	pin_joint_1.node_b = body.get_path()
	add_child(pin_joint_1)
	
	var pin_joint_2 := PinJoint2D.new()
	pin_joint_2.position = Vector2(20, 20)
	pin_joint_2.node_a = get_path()
	pin_joint_2.node_b = body.get_path()
	add_child(pin_joint_2)
	
	if Input.is_action_just_pressed("ui_accept"):
		for c in get_children():
			if c is not PinJoint2D:
				continue
			c.queue_free()
	
	gravitation_scale = 1.0
