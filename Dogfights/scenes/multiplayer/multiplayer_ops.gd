extends Node

#@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://scenes/multiplayer/multiship.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

var ps = []
var ROCK : PackedScene = preload('res://scenes/asteroid_scenes/asteroids.tscn')
var SUN : PackedScene = preload('res://scenes/star.tscn')
var rng = RandomNumberGenerator.new()
var SUN_added = false
var x = 90
var nonlocal = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#position += Vector2(20,20)
	#for i in range(0, 90):
	#	rockSpawn(Vector3(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0)))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not get_parent().get_node("readyUp").visible:
		$CanvasLayer.visible = false
	#if not get_parent().get_node("readyUp").visible:
	#	$CanvasLayer.visible = false
	#if (!SUN_added):
	#	var instance = SUN.instantiate()
	#	instance.position = Vector3(100.0, 100.0, 0.0)
	#	instance.scale *= 1
	#	get_parent().add_child(instance)
	#	SUN_added = true
	#if (x > 0) :
	#	x -= 1
	#	rockSpawn(Vector3(rng.randf_range(-1000.0, 1000.0), rng.randf_range(-300.0, 300.0), rng.randf_range(-300.0, 300.0)))
	#if not is_multiplayer_authority(): 
		#return
	$CanvasLayer/MarginContainer/VBoxContainer/Sprite2D.visible = true
	var text = ""
	if is_multiplayer_authority():
		#print(ps)
		if $CanvasLayer.visible:
			var l = 0
			for i in ps:
				text += get_node(str(i)).get_node("Username").text + "\n"
			$CanvasLayer/MarginContainer/VBoxContainer/players.text = text
			
			
	#ps = $CanvasLayer/MarginContainer/VBoxContainer/players.text.split("\n")

func rockSpawn(pos: Vector3):
	var instance = ROCK.instantiate()
	instance.position = pos
	instance.scale *= 8
	get_parent().add_child(instance)


func _on_host_pressed():
	#main_menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	add_player(multiplayer.get_unique_id())
	#ps = 1
	if nonlocal:
		upnp_setup()
	#$CanvasLayer/CheckButton.hide()

func _on_join_pressed():
	#ps += 1
	#main_menu.hide()
	if(address_entry.text == ""):
		enet_peer.create_client("localhost", PORT)
	else: 
		enet_peer.create_client(address_entry.text, PORT)
	multiplayer.multiplayer_peer = enet_peer
	#$CanvasLayer/CheckButton.hide()

func add_player(peer_id):
	var player = Player.instantiate()
	ps.append(peer_id)
	player.name = str(peer_id)
	#player.scale *= 0.1
	add_child(player)

func remove_player(peer_id):
	ps.erase(peer_id)
	var player = get_node_or_null(str(peer_id))
	if player:
		#ps -= 1
		player.queue_free()

func upnp_setup():
	var upnp = UPNP.new()
	
	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Discover Failed! Error %s" % discover_result)

	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), \
		"UPNP Invalid Gateway!")

	var map_result = upnp.add_port_mapping(PORT)
	assert(map_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Port Mapping Failed! Error %s" % map_result)
	
	print("Success! Join Address: %s" % upnp.query_external_address())

func _on_check_button_toggled(toggled_on):
	nonlocal = not(nonlocal)
