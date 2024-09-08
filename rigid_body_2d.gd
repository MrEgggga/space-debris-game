extends RigidBody2D

@export var thrust_force: Vector2 = Vector2.UP * 400 * 245 * 1.2

@onready var booster_l: Node2D = $booster_l
@onready var booster_r: Node2D = $booster_r

func _physics_process(delta: float) -> void:
	var force_absolute = thrust_force.rotated(rotation)
	print_debug(force_absolute)
	if Input.is_action_pressed("ui_left"):
		apply_force(force_absolute, booster_l.global_position - global_position)
	if Input.is_action_pressed("ui_right"):
		apply_force(force_absolute, booster_r.global_position - global_position)
