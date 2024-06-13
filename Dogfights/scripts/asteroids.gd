extends Node3D

var IMPACT : PackedScene = preload('res://scenes/asteroid_scenes/asteroidexplode.tscn')
var BOOST : PackedScene = preload('res://scenes/boost_pu.tscn')
var HEAL : PackedScene = preload('res://scenes/health_pu.tscn')
var STRENGTH : PackedScene = preload('res://scenes/strength_pu.tscn')

var rng = RandomNumberGenerator.new()
var x = 90
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not visible:
		explode()

func explode():
	visible = false
	var x = rng.randi_range(1,100)
	if (x <= 10):
		spawnBoost(position)
	if (x > 10 and x <= 18):
		spawnHeal(position)
	if (x > 30 and x <= 33):
		spawnStrength(position)
	impactGen(position)
	queue_free()

func spawnBoost(pos):
	var instance = BOOST.instantiate()
	instance.position = pos
	get_parent().add_child(instance)
	rpc("rpc_spawnBoost",pos)

@rpc func rpc_spawnBoost(pos):
	spawnBoost(pos)

func spawnHeal(pos):
	var instance = HEAL.instantiate()
	instance.position = pos
	get_parent().add_child(instance)
	rpc("rpc_spawnHeal",pos)

@rpc func rpc_spawnHeal(pos):
	spawnHeal(pos)

func spawnStrength(pos):
	var instance = STRENGTH.instantiate()
	instance.position = pos
	get_parent().add_child(instance)
	rpc("rpc_spawnStrength",pos)

@rpc func rpc_spawnStrength(pos):
	spawnStrength(pos)

func impactGen(pos: Vector3):
	var instance = IMPACT.instantiate()
	instance.position = pos
	instance.emitting = true
	get_parent().add_child(instance)
	rpc("rpc_impactGen",pos)

@rpc func rpc_impactGen(pos):
	impactGen(pos)

func _on_area_3d_area_entered(area):
	print(area.get_parent().name)
	if area.is_in_group("player") or area.is_in_group("enemy") or area.is_in_group("laser") or area.is_in_group("charge") or area.is_in_group("blastshot"):
		if area.is_in_group("player"):
			print(get_parent().name)
			get_parent().get_node("multiplayerlvl_2/update").text = area.get_parent().name + " asteroid " + str(randi_range(0,1000))
		explode()
