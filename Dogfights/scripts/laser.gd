extends Node3D

var SPEED = -180
var x
var explode = false
var y = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	$GPUParticles3D.emitting = false
	scale *= 5
	x = 600
	y = 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	x -= 1
	if explode:
		y -= 1
	if (x < 1 or y < 0) :
		queue_free()

func destroy():
	print("yes")
	explode = true
	$GPUParticles3D.emitting = true
	$Area3D/CollisionShape3D.disabled = true
	$Area3D2/CollisionShape3D.disabled = true

func _on_area_3d_area_entered(area):
	destroy()


func _on_area_3d_2_area_entered(area):
	destroy()


func _on_area_3d_body_entered(body):
	destroy()


func _on_area_3d_2_body_entered(body):
	destroy()
