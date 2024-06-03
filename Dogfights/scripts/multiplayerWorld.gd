extends Node

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://scenes/multiplayer/multiplayership.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

var ps = 1

var ROCK : PackedScene = preload('res://scenes/asteroids.tscn')
var SUN : PackedScene = preload('res://scenes/star.tscn')
var rng = RandomNumberGenerator.new()
var SUN_added = false
var x = 90

# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))
	pass

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
		rockSpawn(Vector3(rng.randf_range(-1000.0, 1000.0), rng.randf_range(-300.0, 300.0), rng.randf_range(-300.0, 300.0)))

func rockSpawn(pos: Vector3):
	var instance = ROCK.instantiate()
	instance.position = pos
	instance.scale *= 8
	get_parent().add_child(instance)


func _on_host_pressed():
	main_menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	add_player(multiplayer.get_unique_id())
	ps = 1

func _on_join_pressed():
	ps += 1
	main_menu.hide()
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		#ps -= 1
		player.queue_free()