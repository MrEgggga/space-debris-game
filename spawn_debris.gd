extends Node2D

@export var bounds: Rect2
@export var debris_per_10000_square_pixels: float = 5
@export var debris_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(floor(bounds.get_area() * debris_per_10000_square_pixels / 10000)):
		var debris = debris_scene.instantiate()
		debris.position = Vector2(
			randf_range(bounds.position.x, bounds.position.x + bounds.size.x),
			randf_range(bounds.position.y, bounds.position.y + bounds.size.y),
		)
		add_child(debris)
