extends Node3D

var ROCK : PackedScene = preload('res://scenes/asteroid_scenes/asteroids.tscn')
var LONG_ROCK : PackedScene = preload('res://scenes/asteroid_scenes/long_asteroid.tscn')
var ROCKS = [ROCK, LONG_ROCK]
var SUN : PackedScene = preload('res://scenes/star.tscn')
var NPC : PackedScene = preload('res://scenes/small_npc.tscn')
var rng = RandomNumberGenerator.new()
var SUN_added = false
var x = 500
var y = 0
var played = false;
var p = [Vector3(-40.845,7.791,24.731),Vector3(-5.105,0,-101.239), Vector3(85.386,0,42.732)]
# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))
	$level2/AnimationPlayer.play("fade2")
	played = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	y += 1
	if y % 480 == 0:
		var x = randi_range(0,2)
		spawnNPC(p[x])
	
	if (!SUN_added):
		sun()
	if (x > 0) :
		x -= 1
		rockSpawn(Vector3(rng.randf_range(-50.0, 350.0), rng.randf_range(-50.0, 350.0), rng.randf_range(-50.0, 350.0)))

func sun():
	var instance = SUN.instantiate()
	instance.position = Vector3(100.0, 100.0, 0.0)
	instance.scale *= 1
	get_parent().add_child(instance)
	SUN_added = true
	rpc("rpc_sun")

@rpc func rpc_sun():
	sun()

func spawnNPC(pos):
	var instance = NPC.instantiate()
	instance.position = pos
	add_child(instance)
	rpc("rpc_spawnNPC",pos)

@rpc func rpc_spawnNPC(pos):
	spawnNPC(pos)

func rockSpawn(pos: Vector3):
	var random_rock_type = rng.randi_range(0, 1)
	var instance = ROCKS[random_rock_type].instantiate()
	instance.position = pos
	instance.scale *= rng.randi_range(5, 15)
	get_parent().add_child(instance)
	rpc("rpc_rockSpawn",pos)

@rpc func rpc_rockSpawn(pos):
	rockSpawn(pos)
