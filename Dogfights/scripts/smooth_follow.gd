
class_name SmoothFollow
extends Node3D


@export var target:Node3D

@export var distance:float = 10.0

@export var height:float = 5.0

@export var position_damping:float = 2.0

@export var should_rotate:bool = true

@export var rotation_damping:float = 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target):
		_follow(delta)


func _follow(delta):

	var offset = -target.global_transform.basis.z * distance
	var desired_position = target.position + offset

	desired_position.y += height

	set_position(lerp(get_position(), desired_position, position_damping * delta))

	if (should_rotate == true):
		self.quaternion = MathLib.smooth_look_at(self, target, rotation_damping, delta)
