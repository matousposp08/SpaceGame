extends Node3D
var rotation_speed: float = PI #m/s

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		#child.global_rotation.y = 0
		var dist = position.distance_to(child.position)
		rotate_y(rotation_speed/(2 * PI * dist) * delta)
	pass
