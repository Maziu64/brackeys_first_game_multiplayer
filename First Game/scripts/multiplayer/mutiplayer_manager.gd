extends Node

const SERVER_PORT = 7777
const SERVER_IP = "127.0.0.1"

var multiplayer_scene = preload("res://scenes/multiplayer/multiplayer_player.tscn")

var _players_spawn_node
var host_mode_enabled = false
var multiplayer_mode_enabled = false
var respawn_point = Vector2(40, 30)

func _ready() -> void:
	print("ready")
	
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	'''
	javi me dijo que quizas deberia de poner esto aqui:
	multiplayer.peer_connected.connect(_on_player_add_to_game)
	multiplayer.peer_disconnected.connect(_on_player_deleted)
	'''

func become_host():
	print("Starting host!")
	
	_players_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	multiplayer_mode_enabled = true
	host_mode_enabled = true
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_on_player_add_to_game)
	multiplayer.peer_disconnected.connect(_on_player_deleted)
	
	_on_remove_single_player()
	
	_on_player_add_to_game(1) #Añade personaje con id 1 cuando activa el host

func join_as_player_2():
	print("Player 2 joining")
	multiplayer_mode_enabled = true
	
	var client_peer = ENetMultiplayerPeer.new()
	var status = client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	if status:
		print("Error %d" % status)
	
	multiplayer.multiplayer_peer = client_peer
	
	_on_remove_single_player()

func _on_player_add_to_game(id: int):
	print("Player %s joined the game!" % id)
	
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_players_spawn_node.add_child(player_to_add, true)
	
func _on_player_deleted(id: int):
	print("Player %s left the game!" % id)
	if not _players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()

func _on_remove_single_player():
	print("Remove single player")
	var player_to_remove = get_tree().get_current_scene().get_node("Player")
	player_to_remove.queue_free()

func _on_connected_to_server():
	print("heeeey")

func _on_connection_failed():
	print("connection error")
