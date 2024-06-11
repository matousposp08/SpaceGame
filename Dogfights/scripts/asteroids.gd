extends Node3D

var IMPACT : PackedScene = preload('res://scenes/asteroid_scenes/asteroidexplode.tscn')
var BOOST : PackedScene = preload('res://scenes/boost_pu.tscn')

var rng = RandomNumberGenerator.new()
var x = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func explode():
	if (rng.randi_range(1,10) <= 5):
		spawnBoost(position)
	impactGen(position)
	queue_free()

func spawnBoost(pos):
	var instance = BOOST.instantiate()
	instance.position = pos
	get_parent().add_child(instance)

func impactGen(pos: Vector3):
	var instance = IMPACT.instantiate()
	instance.position = pos
	instance.emitting = true
	get_parent().add_child(instance)

func _on_area_3d_area_entered(area):
	#print(area)
	if area.is_in_group("player") or area.is_in_group("enemy") or area.is_in_group("laser") or area.is_in_group("charge"):
		explode()
