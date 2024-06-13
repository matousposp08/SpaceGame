extends CharacterBody3D


const SPEED = 200.0
const JUMP_VELOCITY = 4.5
var x = 0
var health = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var LASER : PackedScene = preload('res://scenes/laser.tscn')
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var DEATH : PackedScene = preload('res://scenes/planeblowup.tscn')

func _ready():
	$Area3D.add_to_group(name)
	$detector.add_to_group(name)

func _physics_process(delta):
	x += 1
	#print("npc: " + str(health))
	
	if health <= 0:
		death(position, transform.basis)
		queue_free()
	
	#if $RayCast3D.is_colliding():
	#	if $RayCast3D.get_collider().is_in_group("asteroid"):
	#		laser(position, transform.basis)
	
	if (x > 120 and x % 3 == 0) :
		laser(position, transform.basis)
	if x > 240:
		x = 0
	
	#$eyes.look_at(get_parent().get_node("ship").global_position)
	#rotate_y(deg_to_rad($eyes.rotation.y)*0.01)
	#rotate_x(deg_to_rad($eyes.rotation.x)*0.01)
	if get_parent().name == "multiplayerlvl_2":
		var p = get_parent().get_node("multiplayerOps").ps
		var target
		var distance = 10000
		for i in p:
			if (abs(position.length() - get_parent().get_node("multiplayerOps/"+str(i)).position.length())) < distance:
				distance = abs(position.length() - get_parent().get_node("multiplayerOps/"+str(i)).position.length())
				target = get_parent().get_node("multiplayerOps/"+str(i))
		if target != null:
			look_at(target.global_position)
	else:
		#look_at(get_parent().get_node("ship").global_position)
		pass
	
	position += transform.basis * Vector3(0,0,-SPEED) * delta
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
	#	velocity.x = direction.x * SPEED
	#	velocity.z = direction.z * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	#	velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func laser(pos, bas):
	var instance = LASER.instantiate()
	instance.add_to_group(name)
	instance.position = pos
	instance.transform.basis = bas
	instance.SPEED *= -1
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)

func damage(num):
	health -= num

func death(pos, bas):
	var instance = DEATH.instantiate()
	instance.add_to_group(name)
	instance.position = pos
	instance.transform.basis = bas
	instance.emitting = true
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)

func _on_area_3d_area_entered(area):
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
		if area.is_in_group("blastshot"):
			damage(70)


func _on_detector_area_entered(area):
	if (area.is_in_group("asteroids") or area.is_in_group("player")):
		print("pluh")
		laser(position,transform.basis)
