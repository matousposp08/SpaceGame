extends CharacterBody3D

@onready var laser_scene = load("res://scenes/ship_laser.tscn")
var player: CharacterBody3D

func _ready():
	player = $ship

func _process(delta):
	if player and can_shoot():
		shoot_laser()

func can_shoot() -> bool:
	return true

func shoot_laser():
	var laser_instance = laser_scene.instance()
	laser_instance.translation = 5
	get_tree().add_child(laser_instance)
	var direction = (player.translation - 5).normalized()
	laser_instance.set_direction(direction)
