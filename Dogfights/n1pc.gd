extends CharacterBody3D

@onready var laser_scene = load("res://scenes/ship_laser.tscn")
var player: CharacterBody3D
@export var speed: float = 35
@export var acceleration: float = 1000
var accelerating: bool = false
var health = 1000
var mission_time = 3600
var x = 0

#shiptrails stuff
var exhaust_model = load("res://scenes/exhaust.tscn")
var exhaust

func _ready() -> void:
	exhaust = exhaust_model.instantiate()
	exhaust.emitting = true
	player = $ship
	var timer = Timer.new()
	timer.wait_time = 60.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()

func _physics_process(delta: float) -> void:
	mission_time -= 1
	x += 1
	#$MeshInstance3D.look_at(get_parent().get_node("ship").position)
	#print((get_parent().get_node("ship").position))
	#print($MeshInstance3D.transform.basis)
	#print($MeshInstance3D.rotation)
	if (x % 15 == 0):
		move_ship_trail(exhaust)
	if (x % 180 == 0) :
		#print("shot")
		shoot_laser(global_position, transform.basis)
	if accelerating:
		speed += acceleration * delta
	position.x += speed * delta

func _on_Timer_timeout() -> void:
	accelerating = true


#func _process(delta: float) -> void:
#	if player and can_shoot():
#		shoot_laser()

func can_shoot() -> bool:
	return true

func shoot_laser(pos, bas):
	var instance = laser_scene.instantiate()
	#print(get_parent().name)
	instance.position = pos
	#instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
	if get_parent().name == "multiplayerlvl_1":
		rpc("rpc_shoot_laser",pos,bas)
	
@rpc func rpc_shoot_laser(pos,bas):
	shoot_laser(pos,bas)

func move_ship_trail(exhaust):
	var pos = get_parent().get_node("npc").global_position
	pos.x -= 30
	exhaust.position = pos
	get_parent().add_child(exhaust)


func _on_area_3d_area_entered(area):
	if not (area.is_in_group("enemy")) :
		if (area.is_in_group("laser")):
			health -= 2
		if (area.is_in_group("charge")):
			health -= 50
		if (area.is_in_group("blastshot")):
			health -= 70
