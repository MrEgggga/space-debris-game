## class of rocket player controller

extends Gravitated
class_name Rocket

# thrust force per booster
@export var thrust_force: Vector2 = Vector2.UP * 10000
@export var initial_fuel: float = 90.0
@export var initial_time: float = 300.0

# children that we need to refer to
@onready var booster_l: Node2D = $booster_l
@onready var booster_r: Node2D = $booster_r

# fuel & time numbers
@onready var fuel_left: float = initial_fuel
@onready var time_left: float = initial_time

# score
var score := 0.0

func _physics_process(delta: float) -> void:
	super(delta)
	
	# decrease time left
	time_left -= delta
	
	# apply thrust force if input, but don't allow this
	# if fuel is out. expend fuel every time force is used
	var force_absolute = thrust_force.rotated(rotation)
	if Input.is_action_pressed("ui_left") and fuel_left > 0:
		# apply force from position of left booster
		apply_force(force_absolute, booster_l.global_position - global_position)
		fuel_left -= delta
	if Input.is_action_pressed("ui_right") and fuel_left > 0:
		# apply force from position of left booster
		apply_force(force_absolute, booster_r.global_position - global_position)
		fuel_left -= delta
	
	# display center of mass with color rect
	$color_rect.position = center_of_mass - Vector2(5, 5)
	
	# update ui -- bg bar shows time, fg bar shows fuel, label shows score
	$canvas_layer/bg.anchor_right = time_left / initial_time
	$canvas_layer/fg.anchor_right = fuel_left / initial_fuel
	$canvas_layer/label.text = "%d debris removed !" % score
	
	# remove all debris when in the atmosphere & add it to score
	if position.y > -2500:
		# delete every debris and add it to score
		for c in get_children():
			# don't remove objects intrinsic to the rocket.
			# this is like the worst way of doing it but limited time etc
			if c in [$texture_rect, $collision_shape_2d, $booster_l, $booster_r, $camera_2d, $color_rect, $collision_shape_2d2, $canvas_layer]:
				continue
			c.queue_free()
			# 2 nodes per debris, 1 point per debris = 0.5 points per node
			# this part also sucks
			score += 0.5
		
		# reset mass properties after debris is removed
		center_of_mass = Vector2.ZERO
		mass = 400
		inertia = 300000
	
	# if we're too low to the ground, we've probably crashed --
	# remove all fuel and time to prevent player from moving
	if position.y > -25:
		initial_fuel = 0
		fuel_left = -10
		initial_time = 0
		time_left = -10


func _on_body_entered(body: Node) -> void:
	# recover fuel fully when landing on earth & partially when collecting debris
	if body is StaticBody2D:
		fuel_left = initial_fuel * (time_left / initial_time)
	else:
		fuel_left += 2


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# wrap around
	if position.x > 16384:
		position.x -= 32768
