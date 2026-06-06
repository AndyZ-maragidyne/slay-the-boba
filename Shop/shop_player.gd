extends Node2D

@export var deviceId: int = 0
@export var playerId: int
var coins:int
var maxEnergy:int

var deck = []
var readyUp = false
var endTurn = false

func _ready() -> void:
	if playerId == 0:
		$Icon1.visible = true
	elif playerId == 1:
		$Icon2.visible = true
	elif playerId == 2:
		$Icon3.visible = true
	elif playerId == 3:
		$Icon4.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select_R_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Select_L_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Left_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Right_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Up_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("Down_%s" % playerId) and event.device == deviceId:
		if !readyUp:
			get_parent().get_parent().getInput(event, playerId)
	elif event.is_action_pressed("A_%s" % playerId) and event.device == deviceId:
		var item = get_parent().get_parent().getItemData(playerId)
		print(item)
		if item.card and item.cost <= coins:
			var product = item.Item.instantiate()
			globals.getDeck(playerId).append(product)
			setCoins(-item.cost)
	elif event.is_action_pressed("Select_R2_%s" % playerId) and event.device == deviceId:
		displayDeck()
		pass
	elif event.is_action_released("Select_R2_%s" % playerId) and event.device == deviceId:
		unDisplayDeck()
	elif event.is_action_pressed("Y_%s" % playerId) and event.device == deviceId:
		readyUp = !readyUp
		$Ready.visible = readyUp
		if readyUp:
			get_parent().checkReadyUp()
		

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
