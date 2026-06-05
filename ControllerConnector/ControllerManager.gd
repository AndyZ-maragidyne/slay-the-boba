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
	get_tree().change_scene_to_file("res://shop.tscn")

func initializeDecks():
	var smallCup = preload("res://Cards/SmallCup.tscn")
	var mediumCup = preload("res://Cards/MediumCup.tscn")
	var largeCup = preload("res://Cards/LargeCup.tscn")
	var takeOrder = preload("res://Cards/TakeOrder.tscn")
	var milkyTea = preload("res://Cards/MilkyTea.tscn")
	var instantBoba = preload("res://Cards/InstantTapioca.tscn")
	
	var q1 = preload("res://Cards/Milk.tscn")
	var q2 = preload("res://Cards/Water.tscn")
	var q3 = preload("res://Cards/Tea.tscn")
	var q4 = preload("res://Cards/RefineCrystals.tscn")
	var q5 = preload("res://Cards/Extra Shift.tscn")
	var q6 = preload("res://Cards/Overtime.tscn")
	var q7 = preload("res://Cards/EnergyDrink.tscn")
	var q8 = preload("res://Cards/Clean.tscn")
	var q9 = preload("res://Cards/EatIngredients.tscn")
	var q10 = preload("res://Cards/TakeOrder.tscn")
	
	var index = 0
	for p in globals.joinedPlayers:
		#var newCard = q1.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q2.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q3.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q4.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q5.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q6.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q7.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q8.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q9.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = q10.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = mediumCup.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = mediumCup.instantiate()
		#globals.playerDecks[index].append(newCard)
		#newCard = mediumCup.instantiate()
		#globals.playerDecks[index].append(newCard)
		
		var newCard = smallCup.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = smallCup.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = mediumCup.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = mediumCup.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = largeCup.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = takeOrder.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = takeOrder.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = milkyTea.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = milkyTea.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = milkyTea.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = milkyTea.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = milkyTea.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = instantBoba.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = instantBoba.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = instantBoba.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = instantBoba.instantiate()
		globals.playerDecks[index].append(newCard)
		newCard = instantBoba.instantiate()
		globals.playerDecks[index].append(newCard)
		index += 1
	
