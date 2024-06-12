extends Node3D

var direction = Vector3.ZERO
@export var speed: float = 220.0

func _ready():
	if get_parent().name == "multiplayerlvl_1":
		var p = get_tree().get_nodes_in_group("player")
		var target
		var distance = 10000
		for i in p:
			if (position.length() - i.position.length()) < distance:
				target = i
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
