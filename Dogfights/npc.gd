extends Node

@export var laser_speed: float = 10.0
@export var shooting_interval: float = 2.0
@export var laser_mesh: Mesh
@export var player: NodePath

var laser_instance: MeshInstance3D
var shooting_timer: Timer

func _ready():
	shooting_timer = Timer.new()
	shooting_timer.wait_time = shooting_interval
	shooting_timer.connect("timeout", self, "_on_shooting_timer_timeout")
	add_child(shooting_timer)
	shooting_timer.start()

func _on_shooting_timer_timeout():
	shoot_laser()

func shoot_laser():
	if laser_instance:
		laser_instance.queue_free()
	laser_instance = MeshInstance3D.new()
	laser_instance.mesh = laser_mesh
	add_child(laser_instance)
	laser_instance.global_transform = $Laser.global_transform
	laser_instance.visible = true

	var direction = (get_node(player).global_transform.origin - global_transform.origin).normalized()
	laser_instance.look_at(get_node(player).global_transform.origin, Vector3.UP)

	var laser_timer = Timer.new()
	laser_timer.wait_time = 0.1
	laser_timer.connect("timeout", self, "_on_laser_timer_timeout", [direction])
	add_child(laser_timer)
	laser_timer.start()

func _on_laser_timer_timeout(direction):
	if laser_instance:
		laser_instance.global_transform.origin += direction * laser_speed * get_physics_process_delta_time()

	if laser_instance and laser_instance.global_transform.origin.distance_to(get_node(player).global_transform.origin) < 1.0:
		print("Laser hit the player!")
		laser_instance.queue_free()
