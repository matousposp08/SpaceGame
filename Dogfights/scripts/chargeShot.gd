extends Node3D

var SPEED = -300
var x
var explode = false
var y = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= 5
	x = 600
	print("op")
	print(get_groups())
	$Area3D.add_to_group(get_groups()[0])
	$Area3D.add_to_group(get_groups()[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	x -= 1
	if explode:
		y -= 1
	if (x < 1 or y < 1) :
		queue_free()


func destroy():
	#print("yes")
	explode = true
	$GPUParticles3D.emitting = true
	$Area3D/CollisionShape3D.disabled = true

func _on_area_3d_area_entered(area):
	if not area.is_in_group(get_groups()[0]) and not area.is_in_group(get_groups()[1]):
		destroy()


func _on_area_3d_body_entered(body):
	if not body.is_in_group(get_groups()[0]) and not body.is_in_group(get_groups()[1]):
		destroy()
