extends Node3D

var SMALL_ROCK : PackedScene = preload('res://scenes/asteroid_scenes/asteroids.tscn')
var LONG_ROCK : PackedScene = preload('res://scenes/asteroid_scenes/long_asteroid.tscn')
var ROCKS = [SMALL_ROCK, LONG_ROCK]
var SUN : PackedScene = preload('res://scenes/star.tscn')
var rng = RandomNumberGenerator.new()
var SUN_added = false
var x = 90
var played = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))
	$level1/AnimationPlayer.play("fade")
	played = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if (!SUN_added):
		var instance = SUN.instantiate()
		instance.position = Vector3(100.0, 100.0, 0.0)
		instance.scale *= 1
		get_parent().add_child(instance)
		SUN_added = true
	if (x > 0) :
		x -= 1
		
		rockSpawn(Vector3(rng.randf_range(-50.0, 50.0), rng.randf_range(-50.0, 50.0), rng.randf_range(-50.0, 50.0)))

func rockSpawn(pos: Vector3):
	var random_rock_type = rng.randi_range(0, 1)
	var instance = ROCKS[random_rock_type].instantiate()
	instance.position = pos
	instance.scale *= rng.randi_range(1, 5)
	get_parent().add_child(instance)
