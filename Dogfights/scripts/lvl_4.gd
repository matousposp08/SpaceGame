extends Node3D

var SUCCESS : PackedScene = preload('res://scenes/success.tscn')
# Called when the node enters the scene tree for the first time.

@onready var ship = $ship

func _ready():
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if (!SUN_added):
		#var instance = SUN.instantiate()
		#instance.position = Vector3(100.0, 100.0, 0.0)
		#instance.scale *= 1
		#get_parent().add_child(instance)
		#SUN_added = true
	if (ship.position.z >= 460) :
		var instance = SUCCESS.instantiate()
		get_parent().add_child(instance)
