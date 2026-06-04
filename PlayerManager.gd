extends Node2D

@export var playerScene: PackedScene

#Keeps track of every player
var activePlayers: Dictionary = {}
#Idk what this is it's literally not used
var playersPlaying: Array[Node2D] = []

func _ready() -> void:
	var index = 0
	for device_id in globals.joinedPlayers:
		spawn_player(device_id, index, globals.playerData[index])
		index += 1
	
	setPlayerPositions()
	get_parent().startTurn()

#func _on_joy_connection_changed(device_id: int, connected:bool) -> void:
	#if connected:
		#spawn_player(device_id)
	#else:
		#remove_player(device_id)

func spawn_player(device_id: int, player_id:int, playerData:PlayerData) -> void:
	if activePlayers.has(device_id):
		return
	var joy_name = Input.get_joy_name(device_id)
	print("Device ", device_id, " connected: ", joy_name)
	print("Playuer Id:" + str(player_id))
	
	if not playerScene:
		print("No scene assigned in the inspector.")
		return
	
	var newPlayer = playerScene.instantiate()
	newPlayer.deviceId = device_id
	newPlayer.playerId = player_id
	for card in globals.playerDecks[player_id]:
		newPlayer.deck.append(card.duplicate())
	newPlayer.deck.shuffle()
	
	#playerData.coins
	newPlayer.coins = playerData.coins
	newPlayer.maxEnergy = playerData.maxEnergy
	
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
		if !currentPlayer.endTurn and !currentPlayer.hide:
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
