extends Node3D

var material : ShaderMaterial;

func _ready():
	$Timer.start()
	material = $MeshInstance3D.get_active_material(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	add_trail()
	if ($Timer.is_stopped()):
		queue_free()

func add_trail():
	var fix_time  = $Timer.wait_time - $Timer.time_left
	print(fix_time)
	material.set_shader_parameter("outside_time", fix_time)
	
