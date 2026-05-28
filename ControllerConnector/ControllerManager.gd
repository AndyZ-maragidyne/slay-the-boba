extends Node2D


var controllers:Array[int] = []
var playerOrder:Array[int] = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		print("pressed")
		var device = event.device
		if not controllers.has(device):
			print(Input.get_joy_name(device))
			controllers.append(device)
			$ConnectedControllers.addController(Input.get_joy_name(device))
	elif event.is_action_pressed("X"):
		var device = event.device
		if controllers.has(device) and not playerOrder.has(device):
			assignPlayer(device)
		pass
	elif event.is_action_pressed("B"):
		var device = event.device
		if playerOrder.has(device):
			playerOrder.erase(device)
			displayPlayers()
	elif event.is_action_pressed("Y"):
		startGame()

func assignPlayer(device):
	if playerOrder.size() < 4:
		playerOrder.append(device)
		displayPlayers()
	pass

func displayPlayers():
	$P1.text = "Press X to connect..."
	$P2.text = "Press X to connect..."
	$P3.text = "Press X to connect..."
	$P4.text = "Press X to connect..."
	if playerOrder.size() >= 1:
		$P1.text = "Player 1: " + str(Input.get_joy_name(playerOrder[0]))
	if playerOrder.size() >= 2:
		$P2.text = "Player 2: " + str(Input.get_joy_name(playerOrder[1]))
	if playerOrder.size() >= 3:
		$P3.text = "Player 3: " + str(Input.get_joy_name(playerOrder[2]))
	if playerOrder.size() >= 4:
		$P4.text = "Player 4: " + str(Input.get_joy_name(playerOrder[3]))

func startGame():
	globals.joinedPlayers = playerOrder
	get_tree().change_scene_to_file("res://main.tscn")
