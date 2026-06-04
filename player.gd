extends CharacterBody2D

@export var deviceId: int = 0
@export var playerId: int

var endTurn: bool = false
var hide:bool = false
var displayingDeck = false
var energy = 0
var maxEnergy = 3
var coins:int
var deck: Array[Node2D] = []
var hand: Array[Node2D] = []
var discard: Array[Node2D] = []

var mixingSelectedIndex = -1
var mixingSpots = null
func _ready() -> void:
	pass
	
	
func addCard(card:Card):
	deck.append(card)
	updateCardCounts()

func shuffle():
	deck.shuffle()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X_%s" % playerId) and event.device == deviceId:
		#send order
		if get_parent().get_parent().get_node("Drinks").drinkSpots.size() > 0:
			get_parent().get_parent().get_node("Drinks").sendOrder()
			get_parent().get_parent().modifyOrderAutoSending(false)
		pass
	elif event.is_action_pressed("Y_%s" % playerId) and event.device == deviceId:
		#end turn
		endTurn = !endTurn
		if endTurn:
			var discard_tween = create_tween().set_parallel(true)
			discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			discard_tween.tween_property(self, "global_position", Vector2(global_position.x, global_position.y + 500), 0.4)
			get_parent().setPlayerPositions()
			discard_tween.chain().tween_callback(func():
				get_parent().get_parent().checkEndTurn()
				$Hand.deselect()
				$Hand.currentState = $Hand.selectState.SELECTING_CARD
			)
		else:
			get_parent().setPlayerPositions()
	elif event.is_action_pressed("Select_L2_%s" % playerId) and event.device == deviceId:
		hide = !hide
		if hide:
			var discard_tween = create_tween().set_parallel(true)
			discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			discard_tween.tween_property(self, "global_position", Vector2(global_position.x, global_position.y + 500), 0.4)
			get_parent().setPlayerPositions()
		else:
			get_parent().setPlayerPositions()
	elif event.is_action_pressed("Select_R2_%s" % playerId) and event.device == deviceId:
		displayDeck()
		pass
	elif event.is_action_released("Select_R2_%s" % playerId) and event.device == deviceId:
		unDisplayDeck()
	#This is all for selecting the measuring cups
	elif event.is_action_pressed("Up_%s" % playerId) and event.device == deviceId:
		if $Hand.currentState == $Hand.selectState.SELECTING_CARD:
			$Hand.currentState = $Hand.selectState.OTHER
			mixingSelectedIndex = 0
			if $Hand.hand[$Hand.selected_index]:
				$Hand.hand[$Hand.selected_index].set_selected(false, playerId)
			mixingSpots = get_parent().get_parent().get_node("Mixing").mixingSpots
			mixingSpots[mixingSelectedIndex].set_selected(true, playerId)
	elif event.is_action_pressed("Down_%s" % playerId) and event.device == deviceId or event.is_action_pressed("B_%s" % playerId) and event.device == deviceId:
		if $Hand.currentState == $Hand.selectState.OTHER:
			mixingSpots[mixingSelectedIndex].set_selected(false, playerId)
			$Hand.currentState = $Hand.selectState.SELECTING_CARD
			if $Hand.hand[$Hand.selected_index]:
				$Hand.hand[$Hand.selected_index].set_selected(true, playerId)
	elif event.is_action_pressed("Left_%s" % playerId) and event.device == deviceId:
		if $Hand.currentState == $Hand.selectState.OTHER:
			mixingSpots[mixingSelectedIndex].set_selected(false, playerId)
			if mixingSelectedIndex >= mixingSpots.size() - 1:
				mixingSelectedIndex = 0
			else:
				mixingSelectedIndex += 1
			mixingSpots[mixingSelectedIndex].set_selected(true, playerId)
	elif event.is_action_pressed("Right_%s" % playerId) and event.device == deviceId:
		if $Hand.currentState == $Hand.selectState.OTHER:
			mixingSpots[mixingSelectedIndex].set_selected(false, playerId)
			if mixingSelectedIndex < 0:
				mixingSelectedIndex = mixingSpots.size() - 1
			else:
				mixingSelectedIndex -= 1
			mixingSpots[mixingSelectedIndex].set_selected(true, playerId)
	elif event.is_action_pressed("A_%s" % playerId) and event.device == deviceId:
		if $Hand.currentState == $Hand.selectState.OTHER and mixingSpots[mixingSelectedIndex].isReady:
			var output = mixingSpots[mixingSelectedIndex].grabDrink()
			if output:
				mixingSpots[mixingSelectedIndex].set_selected(false, playerId)
				$Hand.currentState = $Hand.selectState.SELECTING_CARD
				hand.append(output)
				$Hand.add_child(output)
				$Hand.update_hand_layout()

func updateCardCounts():
	$Deck.text = str(deck.size())
	$Discard.text = str(discard.size())

func resetEnergy():
	energy = maxEnergy
	updateEnergy()

func updateEnergy():
	$Energy.text = str(energy)

func convertToData():
	return PlayerData.new(3, coins)

func displayDeck():
	var names = "[b]Draw:[/b]\n"
	var tempName:Array[String] = []
	for c in deck:
		tempName.append(c.cardName)
	tempName.shuffle()
	for c in tempName:
		names += c + "\n"
	names += "[b]Hand:[/b]\n"
	tempName.clear()
	for c in hand:
		tempName.append(c.cardName)
	tempName.shuffle()
	for c in tempName:
		names += c + "\n"
	names += "[b]Discard:[/b]\n"
	tempName.clear()
	for c in discard:
		tempName.append(c.cardName)
	tempName.shuffle()
	for c in tempName:
		names += c + "\n"
	tempName.clear()
	$FullDeck.text = names
	$FullDeck.visible = true
	hide = true
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	discard_tween.tween_property(self, "global_position", Vector2(global_position.x, global_position.y + 500), 0.4)
	displayingDeck = true
	get_parent().setPlayerPositions()
	#get the globals deck
	#for everything in the deck
	#write out the name and \n
	#make the label say it and turn the visible to true
	pass
	
func unDisplayDeck():
	$FullDeck.visible = false
	hide = false
	displayingDeck = false
	get_parent().setPlayerPositions()
