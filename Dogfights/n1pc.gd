extends CharacterBody3D

@onready var laser_scene = load("res://scenes/ship_laser.tscn")
var player: CharacterBody3D
@export var speed: float = 10.0
@export var acceleration: float = 50.0
var accelerating: bool = false


func _ready() -> void:
	player = $ship
	var timer = Timer.new()
	timer.wait_time = 15.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()


func _physics_process(delta: float) -> void:
	if accelerating:
		speed += acceleration * delta
	position.x += speed * delta


func _on_Timer_timeout() -> void:
	accelerating = true


func _process(delta: float) -> void:
	if player and can_shoot():
		shoot_laser()

func can_shoot() -> bool:
	return true

func shoot_laser() -> void:
	var laser_instance = laser_scene.instantiate()
	laser_instance.translation = player.translation + Vector3(0, 0, 5)
	get_tree().current_scene.add_child(laser_instance)
	var direction = (player.translation - Vector3(0, 0, 5)).normalized()
	laser_instance.set("direction", direction)
