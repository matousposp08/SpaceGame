extends CharacterBody3D

@export var laser_speed: float = 10.0
@export var shooting_interval: float = 2.0
@export var laser_mesh: Mesh
@export var player: NodePath
var x = 0

var LASER : PackedScene = preload('res://scenes/ship_laser.tscn')
#var laser_instance: MeshInstance3D
var shooting_timer: Timer

func _physics_process(delta):
	x += 0.5
	if x % 180 == 0:
		laser(position, transform.basis)

func laser(pos, bas):
	var instance = LASER.instantiate()
	instance.position = pos
	instance.transform.basis = bas
	get_parent().add_child(instance)
