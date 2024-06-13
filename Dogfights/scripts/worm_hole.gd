extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	if not is_in_group("player"):
		if area.is_in_group("player"):
			print(get_parent().name)
			get_parent().get_node("update").text = area.get_parent().name + " wormhole " + str(randi_range(0,1000))
