extends Node3D

var IMPACT : PackedScene = preload('res://scenes/asteroidexplode.tscn')
var rng = RandomNumberGenerator.new()
var x = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func explode():
	impactGen(position)
	queue_free()

func impactGen(pos: Vector3):
	var instance = IMPACT.instantiate()
	instance.position = pos
	instance.emitting = true
	get_parent().add_child(instance)

func _on_area_3d_area_entered(area):
	explode()
	print("Boom")
