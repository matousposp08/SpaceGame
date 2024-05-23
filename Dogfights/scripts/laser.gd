extends Node3D

var SPEED = 30
var x
# Called when the node enters the scene tree for the first time.
func _ready():
	x = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	x -= 1
	if (x < 1) :
		queue_free()
