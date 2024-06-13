extends RigidBody3D
@export var player_num: int
@export var sun: StaticBody3D
var unclaimed: Color = Color(0.41, 0.41, 0.41, 1.0)
var blue: Color = Color(0.12, 0.64, 0.70, 1.0)
var red: Color = Color(0.75, 0.11, 0.11, 1.0)
#var planet_color = Vector3(105.0, 105.0, 105.0) #Unclaimed color

# Called when the node enters the scene tree for the first time.
func switch():
	if (player_num == 0):
		set_color(blue)
		#sun_pos = 
	else:
		set_color(red)
		
func _ready():
	switch()
	pass # Replace with function body.

func set_color(color):
	$MeshInstance3D.set_instance_shader_parameter("albedo", Vector4(color.r, color.g, color.b, 1.0))
	pass
	
func _physics_process(delta):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
