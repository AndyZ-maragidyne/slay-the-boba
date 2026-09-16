extends Node2D


var controllers:Array[int] = []
var playerOrder:Array[int] = []

func _ready() -> void:
	$P1.text = "Press X to connect..."
	$P2.text = "Press X to connect..."
	$P3.text = "Press X to connect..."
	$P4.text = "Press X to connect..."
	
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
	initializeDecks()
	get_tree().change_scene_to_file("res://main.tscn")

func initializeDecks():
	var smallCup = preload("res://Cards/SmallCup.tres")
	var mediumCup = preload("res://Cards/MediumCup.tres")
	var largeCup = preload("res://Cards/LargeCup.tres")
	var takeOrder = preload("res://Cards/TakeOrder.tres")
	var milkyTea = preload("res://Cards/MilkyTea.tres")
	var instantBoba = preload("res://Cards/InstantTapioca.tres")
	var card = preload("res://Cards/Card.tscn")
	#
	var q1 = preload("res://Cards/MilkTea.tres")
	var q2 = preload("res://Cards/Water.tres")
	var q3 = preload("res://Cards/Boba.tres")
	#var q4 = preload("res://Cards/RefineCrystals.tscn")
	#var q5 = preload("res://Cards/Extra Shift.tscn")
	#var q6 = preload("res://Cards/Overtime.tscn")
	#var q7 = preload("res://Cards/EnergyDrink.tscn")
	#var q8 = preload("res://Cards/Clean.tscn")
	#var q9 = preload("res://Cards/EatIngredients.tscn")
	#var q10 = preload("res://Cards/TakeOrder.tscn")
	
	var index = 0
	for p in globals.joinedPlayers:
		#used for testing
		#var cardS = Card.create(q1)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(q1)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(q1)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(smallCup)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(mediumCup)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(largeCup)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(takeOrder)
		#globals.playerDecks[index].append(cardS)
		#cardS = Card.create(instantBoba)
		#globals.playerDecks[index].append(cardS)

		
		var cardS = Card.create(smallCup)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(smallCup)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(mediumCup)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(mediumCup)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(largeCup)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(takeOrder)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(takeOrder)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q1)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q1)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q1)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q1)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q1)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q3)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q3)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q3)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q3)
		globals.playerDecks[index].append(cardS)
		cardS = Card.create(q3)
		globals.playerDecks[index].append(cardS)
		index += 1
	
