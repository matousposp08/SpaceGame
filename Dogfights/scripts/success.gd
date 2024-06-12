extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.playing = true
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_nextlevel_pressed():
	get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
