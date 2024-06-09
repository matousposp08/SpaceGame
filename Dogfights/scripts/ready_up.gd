extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.playing = true
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$AudioStreamPlayer.playing = false
	get_tree().paused = false
	queue_free()
