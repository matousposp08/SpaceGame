extends CharacterBody3D


var SPEED = -3
const JUMP_VELOCITY = 4.5
var xvel = 0
var yvel = 0
var rev = 0
var charge = 0
var health = 100
var shield = 100

var LASER : PackedScene = preload('res://scenes/laser.tscn')
var CHARGE : PackedScene = preload('res://scenes/charge_shot.tscn')

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
		SPEED = -40
	elif Input.is_action_pressed("brake"):
		SPEED = -8
	else :
		SPEED = -20
	print("a: " + str($Camera3D.rotation_degrees))
	print("b: "+ str(rotation_degrees))
	#$Camera3D.rotation_degrees.x = yvel-10
	#$Camera3D.rotation_degrees.z = xvel
	$ship.rotation_degrees.z = xvel*18
	$ship.rotation_degrees.x = yvel*9
	
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
	
	
	#print(rotation_degrees)
	#rotation_degrees.z = 0
	#rotate_y(xvel*0.02)
	#rotate_x(yvel*0.02)
	#rotation.z = 0
	
	if Input.is_action_pressed("shoot"):
		charge += 1
	if Input.is_action_just_released("shoot") and charge > 40:
		chargeShot(position, transform.basis)
		charge = 0
	elif Input.is_action_just_released("shoot"):
		charge = 0
		laser(position, transform.basis)
	
	rotation_degrees.y -= xvel
	if rotation_degrees.x < 87 or rotation_degrees.x > -87:
		rotation_degrees.x += yvel
	if (Input.is_action_just_pressed("shoot")):
		laser(position, transform.basis)
	
	move_and_slide()
	
#func _input(event):
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	if event is InputEventMouseMotion:
#		transform.basis.x += Vector3.UP * event.relative.y * -0.003
#		transform.basis.y += Vector3.UP * event.relative.x * -0.003
		#parts["head"].rotation.x = clamp(parts["head"].rotation.x, deg_to_rad(-90), deg_to_rad(90))

func reverse():
	if rev < 1: 
		rev = 60

func laser(pos, bas):
	var instance = LASER.instantiate()
	instance.add_to_group("player")
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
	
func chargeShot(pos, bas):
	var instance = CHARGE.instantiate()
	instance.add_to_group("player")
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)


func _on_area_3d_area_entered(area):
	if not area.is_in_group("player"):
		if area.is_in_group("laser"):
			health -= 2
		if area.is_in_group("asteroid"):
			health -= 20
