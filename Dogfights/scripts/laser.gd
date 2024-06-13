extends Node3D

var SPEED = -180
var x
var explode = false
var y = 0
var BLOW : PackedScene = preload('res://scenes/laserblowup.tscn')
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Area3D2/CollisionShape3D.disabled = true
	#$Area3D/CollisionShape3D.disabled = true
	scale *= 5
	x = 600
	y = 60
	#print(get_groups())
	$Area3D.add_to_group(get_groups()[0])
	#$Area3D.add_to_group(get_groups()[1])
	$Area3D2.add_to_group(get_groups()[0])
	#$Area3D2.add_to_group(get_groups()[1])
	#print(get_groups())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	x -= 1
	if y >= 0:
		y -= 1
	else:
		#print("n")
		$Area3D2/CollisionShape3D.disabled = false
		$Area3D/CollisionShape3D.disabled = false
	if (x < 1) :
		queue_free()

func destroy():
	explode = true
	blow(global_position)
	queue_free()

func blow(pos):
	var instance = BLOW.instantiate()
	instance.position = pos
	instance.emitting = true
	get_parent().add_child(instance)
	rpc("rpc_blow",pos)
	
@rpc func rpc_blow(pos):
	blow(pos)

func _on_area_3d_area_entered(area):
	print("n: " + str(area.get_groups()))
	if not area.is_in_group("laser"):
		destroy()


func _on_area_3d_2_area_entered(area):
	print("n: " + str(area.get_groups()))
	if not area.is_in_group("laser"):
		destroy()


func _on_area_3d_body_entered(body):
	print("n: " + str(body.get_groups()))
	if not body.is_in_group("laser"):
		destroy()


func _on_area_3d_2_body_entered(body):
	print("n: " + str(body.get_groups()))
	if not body.is_in_group("laser"):
		destroy()
