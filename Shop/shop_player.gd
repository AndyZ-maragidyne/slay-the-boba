extends Node2D

@export var deviceId: int = 0
@export var playerId: int
var coins:int
var maxEnergy:int

var deck = []
var readyUp = false
var endTurn = false

#Variable to store the card that the player is holding to replace
var holdingReplacingCard
var holdingReplacingCardReal
func _ready() -> void:
	if playerId == 0:
		$Icon1.visible = true
	elif playerId == 1:
		$Icon2.visible = true
	elif playerId == 2:
		$Icon3.visible = true
	elif playerId == 3:
		$Icon4.visible = true

#change to unhandled?
func _input(event: InputEvent) -> void:
	var statesenum = globals.mainGame.MenuState
	var states = globals.mainGame.playerStates
	if not states.has(playerId):
		states[playerId] = statesenum.NORMAL
	
	if states[playerId] == statesenum.NORMAL:
		handleNormal(event)
	elif states[playerId] == statesenum.REPLACING_CARD:
		handleReplacing(event)

func handleNormal(event):
	if event.is_action_pressed("Select_R_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Select_L_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Left") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.moveSelection(event, playerId)
	elif event.is_action_pressed("Right") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.moveSelection(event, playerId)
	elif event.is_action_pressed("Up") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.moveSelection(event, playerId)
	elif event.is_action_pressed("Down") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.moveSelection(event, playerId)
	elif event.is_action_pressed("A") and event.device == deviceId:
		var item = globals.mainGame.getItemData(playerId)
		if item.price <= coins:
			item.buyItem(playerId)
			setCoins(-item.price)
	elif event.is_action_pressed("Select_R2") and event.device == deviceId:
		displayDeck()
		pass
	elif event.is_action_released("Select_R2") and event.device == deviceId:
		unDisplayDeck()
	elif event.is_action_pressed("Y" % playerId) and event.device == deviceId:
		readyUp = !readyUp
		$Ready.visible = readyUp
		if readyUp:
			get_parent().checkReadyUp()

func handleReplacing(event):
	if event.is_action_pressed("Left") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.cardReplaceSelection(event, playerId)
	elif event.is_action_pressed("Right") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.cardReplaceSelection(event, playerId)
	elif event.is_action_pressed("Up") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.cardReplaceSelection(event, playerId)
	elif event.is_action_pressed("Down") and event.device == deviceId:
		if !readyUp:
			globals.mainGame.cardReplaceSelection(event, playerId)
	elif event.is_action_pressed("A") and event.device == deviceId:
		var item = globals.mainGame.getItemData(playerId)
		item.stockCard(holdingReplacingCard)
		globals.mainGame.shelf.displayItems()
		globals.mainGame.playerStates[playerId] = globals.mainGame.MenuState.NORMAL
		holdingReplacingCardReal.queue_free()
		
func setCoins(value:int):
	coins += value
	$Coins.text = "$" + str(coins)

func displayDeck():
	var deck = globals.getDeck(playerId)
	var name = "[b]Deck[/b]:\n"
	for c in deck:
		name += c.cardName + "\n"
	$FullDeck.text = name
	$FullDeck.visible = true
	
func unDisplayDeck():
	$FullDeck.visible = false

func convertToData():
	return PlayerData.new(3, coins)
