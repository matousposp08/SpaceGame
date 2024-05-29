extends CharacterBody3D

var speed: float = 3.0

func _ready():
	pass

func _process(delta):
	translate(Vector3(0, 0, speed * delta))
