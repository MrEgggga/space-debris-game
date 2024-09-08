extends Node2D

@export var bounds: Rect2
# density of debris in range.
@export var debris_per_10000_square_pixels: float = 5
@export var debris_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(floor(bounds.get_area() * debris_per_10000_square_pixels / 10000)):
		var debris = debris_scene.instantiate()
		# put debris in a random position in range,
		# making positions near the top more common than
		# positions near the bottom.
		debris.position = Vector2(
			randf_range(bounds.position.x, bounds.position.x + bounds.size.x),
			randf_range(bounds.position.y, randf_range(bounds.position.y, bounds.position.y + bounds.size.y)),
		)
		# add the debris into the world.
		add_child(debris)
