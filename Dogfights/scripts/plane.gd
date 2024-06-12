extends CharacterBody3D


var SPEED = -3
const JUMP_VELOCITY = 4.5
var xvel = 0
var yvel = 0
var rev = 0
var charge = 0
var health = 100
var shield = 100
var boostpower = 0
var strength = 0
var alive = true

var LASER : PackedScene = preload('res://scenes/laser.tscn')
var CHARGE : PackedScene = preload('res://scenes/charge_shot.tscn')
var BLAST : PackedScene = preload('res://scenes/blast_shot.tscn')
var DEATH : PackedScene = preload('res://scenes/planeblowup.tscn')

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	add_to_group(name)
	$Area3D.add_to_group(name)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	if health <= 0 and alive:
		$ship.visible = false
		death(global_position, transform.basis)
		var timer = Timer.new()
		timer.wait_time = 3.0
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		add_child(timer)
		timer.start()
		alive = false
		return
	if health <= 0 and not alive:
		return
	# As good practice, you should replace UI actions with custom gameplay actions.
	global_transform.origin -= transform.basis.z.normalized() * SPEED * delta
	var input_dir = Input.get_vector("left", "right", "up", "down")
	#var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	if (Input.is_action_pressed("boost")) :
		SPEED = -40
	elif Input.is_action_pressed("brake"):
		SPEED = -8
	else :
		SPEED = -20
	if boostpower > 0:
		if (Input.is_action_pressed("boost")) :
			SPEED = -50
		boostpower -= 1
		SPEED *= 1.5
	#$Camera3D.rotation_degrees.x = yvel-10
	#$Camera3D.rotation_degrees.z = xvel
	$ship.rotation_degrees.z = xvel*18
	$ship.rotation_degrees.x = yvel*9
	$Area3D.rotation_degrees = $ship.rotation_degrees
	
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
	if Input.is_action_just_pressed("shoot") and strength > 0:
		blastShot(position, transform.basis)
		strength -= 1
	elif Input.is_action_pressed("shoot"):
		charge += 1
	elif Input.is_action_just_released("shoot") and charge > 40 and not strength > 0:
		chargeShot(position, transform.basis)
		charge = 0
	elif Input.is_action_just_released("shoot") and not strength > 0:
		charge = 0
		laser(position, transform.basis)
	
	rotation_degrees.y -= xvel
	if rotation_degrees.x < 87 or rotation_degrees.x > -87:
		rotation_degrees.x += yvel
	if (Input.is_action_just_pressed("shoot")) and not strength > 0:
		laser(position, transform.basis)
	
	move_and_slide()
	
func reverse():
	if rev < 1: 
		rev = 60

func laser(pos, bas):
	var instance = LASER.instantiate()
	instance.add_to_group(name)
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)
	
func chargeShot(pos, bas):
	var instance = CHARGE.instantiate()
	instance.add_to_group(name)
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)

func blastShot(pos, bas):
	var instance = BLAST.instantiate()
	instance.add_to_group(name)
	#instance.scale *= 5
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)

func death(pos, bas):
	var instance = DEATH.instantiate()
	instance.add_to_group(name)
	instance.position = pos
	instance.transform.basis = bas
	instance.emitting = true
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)

func damage(num):
	if shield < num and shield > 0:
		shield = 0
		health -= num - shield
	elif shield > 0:
		shield -= num
	else:
		health -= num

func heal(num):
	health += num
	if health > 100:
		shield += health - 100
		health = 100

func _on_Timer_timeout():
	queue_free()

func _on_area_3d_area_entered(area):
	print(area.get_groups())
	if not area.is_in_group(name):
		if area.is_in_group("laser"):
			damage(2)
		if area.is_in_group("asteroid"):
			health -= 20
		if area.is_in_group("charge"):
			print(area.get_groups())
			damage(20)
		if area.is_in_group("blast"):
			damage(50)
		if area.is_in_group("enemyship"):
			damage(30)
		if area.is_in_group("boost"):
			boostpower = 900
		if area.is_in_group("heal"):
			heal(30)
		if area.is_in_group("strength"):
			strength = 5
