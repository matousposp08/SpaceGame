extends Node3D

var SPEED = -1000
var x = 600
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x -= 1
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	if x < 0:
		queue_free()
