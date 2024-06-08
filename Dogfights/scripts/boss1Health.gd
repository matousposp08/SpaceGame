extends CanvasLayer

var h
var s
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	h = (get_parent().health)
	s = get_parent().mission_time
	$ProgressBar.value = h/10
	$ProgressBar2.value = s/36
