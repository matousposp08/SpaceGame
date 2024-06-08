extends CharacterBody3D

@onready var laser_scene = load("res://scenes/ship_laser.tscn")
var player: CharacterBody3D
@export var speed: float = 35.0
@export var acceleration: float = 1
var accelerating: bool = false
var health = 1000
var x = 0

func _ready() -> void:
	player = $ship
	var timer = Timer.new()
	timer.wait_time = 15.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()


func _physics_process(delta: float) -> void:
	x += 1
	if (x % 300 == 0) :
		shoot_laser(position, $MeshInstance3D.transform.basis)
	if accelerating:
		speed += acceleration * delta
	position.x += speed * delta

func _on_Timer_timeout() -> void:
	accelerating = true


#func _process(delta: float) -> void:
#	if player and can_shoot():
#		shoot_laser()

func can_shoot() -> bool:
	return true

func shoot_laser(pos, bas):
	var instance = laser_scene.instantiate()
	instance.position = pos
	instance.transform.basis = bas
	#print(str(position) + " " + str(instance.position))
	get_parent().add_child(instance)


func _on_area_3d_area_entered(area):
	if not (area.is_in_group("enemy")) :
		if (area.is_in_group("laser")):
			health -= 2
		if (area.is_in_group("charge")):
			health -= 50
