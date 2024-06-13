extends Node3D

var ROCK : PackedScene = preload('res://scenes/asteroid_scenes/asteroids.tscn')
var LONG_ROCK : PackedScene = preload('res://scenes/asteroid_scenes/long_asteroid.tscn')
var SUN : PackedScene = preload('res://scenes/star.tscn')
var rng = RandomNumberGenerator.new()
var SUN_added = false
var x = 90
var played = false;

var won = false;
var checkone = false;
var checktwo = false;
var checkthree = false;
var checkfour = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$WIN.hide()
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))
	played = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!SUN_added):
		var instance = SUN.instantiate()
		instance.position = Vector3(100.0, 100.0, 0.0)
		instance.scale *= 1
		get_parent().add_child(instance)
		SUN_added = true
	if (x > 0) :
		x -= 1
		
		rockSpawn(Vector3(rng.randf_range(-500.0, 500.0), rng.randf_range(-500.0, 500.0), rng.randf_range(-500.0, 500.0)))
		
	if(checkone!=true):
		checktwo = false;
		checkthree = false;
		checkfour = false;
	elif(checktwo!=true):
		checkthree = false;
		checkfour = false;
	elif (checkthree!=true):
		checkfour = false;
	
	if(won==true):
		$WIN.show()

func rockSpawn(pos: Vector3):
	var instance = ROCK.instantiate()
	instance.position = pos
	instance.scale *= 8
	get_parent().add_child(instance)


func _on_check_1_area_entered(area):
	checkone = true;
	print("checkpoint one")
	$MeshInstance3D2/on.hide()


func _on_check_2_area_entered(area):
	checktwo = true;
	print("checkpoint two")
	$MeshInstance3D5/dos.hide()


func _on_check_3_area_entered(area):
	checkthree = true;
	print("checkpoint three")
	$MeshInstance3D4/tre.hide()


func _on_check_4_area_entered(area):
	checkfour = true;
	print("checkpoint four")
	$MeshInstance3D/fo.hide()
	won = true;
