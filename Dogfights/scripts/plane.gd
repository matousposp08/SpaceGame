extends CharacterBody3D

var SPEED = -3
const JUMP_VELOCITY = 4.5
var xvel = 0
var yvel = 0
var rev = 0

var LASER : PackedScene = preload('res://scenes/laser.tscn')

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera = $Camera3D

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	var username = get_parent().get_node("CanvasLayer/MainMenu/MarginContainer/VBoxContainer/Username").text
	if(username != ""):
		if not is_multiplayer_authority(): return
		$Username.text = username
		$Username.billboard = true
	else:
		if not is_multiplayer_authority(): return
		$Username.text = "guest"+str(get_parent().ps)
		$Username.billboard = true

func _ready():
	if not is_multiplayer_authority(): return
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	camera.current = true

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	#rotation_degrees.z = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	global_transform.origin -= transform.basis.z.normalized() * SPEED * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	if (Input.is_action_pressed("boost")) :
		SPEED = -8
	elif Input.is_action_pressed("brake"):
		SPEED = -2
	else :
		SPEED = -5
	
	
	if input_dir.x < 0:
		xvel -= 0.1
		if (xvel < -2):
			xvel = -2
	elif input_dir.x > 0:
		xvel += 0.1
		if (xvel > 2):
			xvel = 2
	else :
		if (xvel > 0) :
			xvel -= 0.05
		if (xvel < 0) :
			xvel += 0.05
	if input_dir.y < 0:
		yvel -= 0.1
		if (yvel < -2):
			yvel = -2
	elif input_dir.y > 0:
		yvel += 0.1
		if (yvel > 2):
			yvel = 2
	else :
		if (yvel > 0) :
			yvel -= 0.05
		if (yvel < 0) :
			yvel += 0.05
	
	
	print(rotation_degrees)
	rotation_degrees.z = 0
	rotate_y(xvel*0.02)
	rotate_x(yvel*0.02)
	if (Input.is_action_just_pressed("shoot")) :
		laser(position, transform.basis)
	
	move_and_slide()

#func _input(event):
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	if event is InputEventMouseMotion:
#		transform.basis.x += Vector3.UP * event.relative.y * -0.003
#		transform.basis.y += Vector3.UP * event.relative.x * -0.003
		#parts["head"].rotation.x = clamp(parts["head"].rotation.x, deg_to_rad(-90), deg_to_rad(90))

var mouse_sens = 0.002
var camera_anglev=0

func _input(event):  
	if not is_multiplayer_authority(): return
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)		
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*mouse_sens)
		var changev=-event.relative.y*mouse_sens
		if camera_anglev+changev>-50 and camera_anglev+changev<50:
			camera_anglev+=changev
			rotate_x(changev)

func reverse():
	if not is_multiplayer_authority(): return
	if rev < 1: 
		rev = 60
	else:
		# rotation_degrees.z += 3
		rotation_degrees.y += 3
		rev -= 1

func laser(pos, bas):
	if not is_multiplayer_authority(): return
	var instance = LASER.instantiate()
	instance.position = pos
	instance.transform.basis = bas
	print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
		
