extends CharacterBody3D


var SPEED = -3
const JUMP_VELOCITY = 4.5
var xvel = 0
var yvel = 0
var rev = 0

var LASER : PackedScene = preload('res://scenes/laser.tscn')

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
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
	#rotation.z = 0
	if abs(yvel) > 0:
		$Camera3D.rotation_degrees.x += yvel*0.1
	if abs(xvel) > 0:
		$Camera3D.rotation_degrees.y += xvel*0.1
	
	rotation_degrees.y += xvel
	if rotation_degrees.x < 87 or rotation_degrees.x > -87:
		rotation_degrees.x += yvel
	if (Input.is_action_just_pressed("shoot")) :
		laser(position, transform.basis)
	
	move_and_slide()

func reverse():
	if rev < 1: 
		rev = 60
	else:
		# rotation_degrees.z += 3
		rotation_degrees.y += 3
		rev -= 1

func laser(pos, bas):
	var instance = LASER.instantiate()
	instance.position = pos
	instance.transform.basis = bas
	print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
