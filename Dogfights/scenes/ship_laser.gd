extends Node3D

var direction = Vector3.ZERO
@export var speed: float = 220.0

func _ready():
	if get_parent().name == "multiplayerlvl_1":
		var p = get_parent().get_node("multiplayerOps").ps
		var target
		var distance = 10000
		for i in p:
			if (abs(position.length() - get_parent().get_node("multiplayerOps/"+str(i)).position.length())) < distance:
				distance = abs(position.length() - get_parent().get_node("multiplayerOps/"+str(i)).position.length())
				target = get_parent().get_node("multiplayerOps/"+str(i))
		if target != null:
			look_at(target.global_position)
	else:
		look_at(get_parent().get_node("ship").global_position)
	#var player = get_parent().get_node("ship")
	#print(player.name)
	#look_at(player.global_transform.origin, Vector3.UP)
	pass

func _process(delta):
	var player = get_parent().get_node("ship")
	#print(player.name)
	#look_at(player.global_transform.origin, Vector3.UP)
	position += transform.basis * Vector3(0,0,-speed) * delta
	#print(name + str(position))
	#position += transform.basis * Vector3(0,0,speed) * delta
	#if is_out_of_bounds() or is_colliding():
	#	queue_free()

func set_direction(dir: Vector3):
	direction = dir

func is_out_of_bounds() -> bool:
	return false

func is_colliding() -> bool:
	return false


func _on_area_3d_area_entered(area):
	if get_parent().name == "multiplayer_lvl1" and not is_in_group("player"):
		if area.is_in_group("player"):
			print(get_parent().name)
			get_parent().get_node("update").text = area.get_parent().name + " blast " + str(randi_range(0,1000))
