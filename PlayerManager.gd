extends Node2D

@export var playerScene: PackedScene

var activePlayers: Dictionary = {}
var playersPlaying: Array[Node2D] = []

func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	
	var connected_joypads = Input.get_connected_joypads()
	for device_id in connected_joypads:
		spawn_player(device_id)
	setPlayerPositions()

func _on_joy_connection_changed(device_id: int, connected:bool) -> void:
	if connected:
		spawn_player(device_id)
	else:
		remove_player(device_id)

func spawn_player(device_id: int) -> void:
	if activePlayers.has(device_id):
		return
	var joy_name = Input.get_joy_name(device_id)	
	print("Device ", device_id, " connected: ", joy_name)
	if "Wii U Pro" in joy_name:
		return
	
	if not playerScene:
		print("No scene assigned in the inspector. Bro you're so bad. Lock in")
		return
	
	var newPlayer = playerScene.instantiate()
	newPlayer.deviceId = device_id
	add_child(newPlayer)
	newPlayer.global_position = Vector2(960, 800)
	activePlayers[device_id] = newPlayer
	setPlayerPositions()
	
func remove_player(device_id: int) -> void:
	if activePlayers.has(device_id):
		var playerToRemove = activePlayers[device_id]
		playerToRemove.queue_free()
		
		activePlayers.erase(device_id)
		setPlayerPositions()
		
#1 player: 960
#2 players: 640 1280
#3 players: 480 960 1440 
#4 players: 384 768 1152 1536
func setPlayerPositions():
	var keys = activePlayers.keys()
	var playingPlayers = []
	for k in keys:
		var currentPlayer = activePlayers.get(k)
		if !currentPlayer.endTurn:
			playingPlayers.append(currentPlayer)
	var list = []
	var index = 0
	if playingPlayers.size() == 1:
		list = [960]
	elif playingPlayers.size() == 2:
		list = [500, 1420]
	elif playingPlayers.size() == 3:
		list = [350, 960, 1570]
	elif playingPlayers.size() == 4:
		list = [254, 728, 1192, 1666]
	
	for p in playingPlayers:
		if list.size() > 0:
			var discard_tween = create_tween().set_parallel(true)
			discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			discard_tween.tween_property(p, "global_position", Vector2(list[index], 800), 0.4)
			index += 1
