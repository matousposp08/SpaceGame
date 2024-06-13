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


func _on_area_3d_area_entered(area):
	if not is_in_group("player"):
		if area.is_in_group("player"):
			print(get_parent().name)
			get_parent().get_node("update").text = area.get_parent().name + " blast " + str(randi_range(0,1000))
