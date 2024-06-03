extends CharacterBody3D

@onready var LASER :PackedScene = preload("res://scenes/ship_laser.tscn")
var player: CharacterBody3D
var x = 0

func _ready():
	player = $ship

func _process(delta):
	x += 1
	#$Sketchfab_Scene.look_at(get_parent().get_node("ship"))
	#$Sketchfab_Scene.rotation.x = 0
	#$RayCast3D.look_at()
	if x % 300 == 0 and can_shoot():
		shoot_laser(position, transform.basis)

func can_shoot() -> bool:
	return true

func shoot_laser(pos, bas):
	var instance = LASER.instantiate()
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
