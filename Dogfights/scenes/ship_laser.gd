extends Node3D

var direction = Vector3.ZERO
@export var speed: float = 300.0

func _process(delta):
	position += direction * speed * delta
	if is_out_of_bounds() or is_colliding():
		queue_free()

func set_direction(dir: Vector3):
	direction = dir

func is_out_of_bounds() -> bool:
	return false

func is_colliding() -> bool:
	return false
