extends CanvasLayer

var h
var s
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var h = get_parent().health
	var s = get_parent().shield
	$Node2D/ProgressBar.value = h
	$Node2D/ProgressBar2.value = s
