extends Node3D

var ROCK : PackedScene = preload('res://scenes/asteroids.tscn')
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 90):
		rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func rockSpawn(pos: Vector3):
	var instance = ROCK.instantiate()
	instance.position = pos
	get_parent().add_child(instance)
