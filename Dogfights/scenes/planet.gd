extends RigidBody3D
@export var player_num: int
@export var sun: StaticBody3D
var unclaimed: Color = Color(0.41, 0.41, 0.41, 1.0)
var blue: Color = Color(0.12, 0.64, 0.70, 1.0)
var red: Color = Color(0.75, 0.11, 0.11, 1.0)
var rotation_speed: float = 1.0
#var planet_color = Vector3(105.0, 105.0, 105.0) #Unclaimed color

# Called when the node enters the scene tree for the first time.
func switch():
	if (player_num == 0):
		set_color(blue)
	else:
		set_color(red)
		
func _ready():
	switch()
	pass # Replace with function body.

func set_color(color):
	var newMaterial = $MeshInstance3D.StandardMaterial3D.new()
	newMaterial.albedo_color = color
	$MeshInstance3D.material_override = newMaterial
	pass
	
func _physics_process(delta):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
