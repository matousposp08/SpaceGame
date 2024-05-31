extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D/ProgressBar.value = get_parent().health
	$Node2D/ProgressBar2.value = get_parent().shield
