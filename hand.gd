extends Node2D

@export var card_scene:PackedScene

@export var spread_distance:float = 80.0
@export var height_curve:float = 12.0
@export var rotation_curve:float = 6.0
@export var animation_speed:float = 0.3

#Other is currently used for if the player is selecting a mixing cup without having a card selected
enum selectState { SELECTING_CARD, SELECTING_DRINK, OTHER }
var currentState: selectState = selectState.SELECTING_CARD

var playerId
var deviceId
var hand: Array[Node2D]
var deck: Array[Node2D]
var discard: Array[Node2D]
var selected_index = -1

var avaliable_spots: Array[Array]
#This is used to tell whether the selector is on the drinkSpots or the mixingSpots
var selectedRow = 0
var selected_drink_index = -1

@onready var player = get_parent()
@onready var discardPileMarker: Node2D = $DiscardPile

func _ready() -> void:
	if get_parent():
		playerId = get_parent().playerId
		deviceId = get_parent().deviceId
		hand = get_parent().hand
		deck = get_parent().deck
		discard = get_parent().discard
	avaliable_spots.append(get_node("../../../Drinks").drinkSpots)
	avaliable_spots.append(get_node("../../../Mixing").mixingSpots)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_card()
	
	if hand.size() == 0 or player.endTurn:
		return
	
	if currentState == selectState.SELECTING_CARD:
		handle_card_selection_input(event)
	elif currentState == selectState.SELECTING_DRINK:
		handle_drink_selection_input(event)
	elif currentState == selectState.OTHER:
		return
	
func handle_card_selection_input(event:InputEvent) -> void:
	if event.is_action_pressed("Select_R_%s" % playerId) and event.device == deviceId:
		selected_index = (selected_index + 1) % hand.size()
		update_hand_layout()
		
	elif event.is_action_pressed("Select_L_%s" % playerId) and event.device == deviceId:
		if selected_index <= 0:
			selected_index = hand.size() - 1
		else:
			selected_index -= 1
		update_hand_layout()
	
	elif event.is_action_pressed("A_%s" % playerId) and selected_index != -1 and event.device == deviceId:
		if hand[selected_index]:
			hand[selected_index].set_selected(false, playerId)
			if hand[selected_index].spawnItem:
				enter_targeting_mode()
			else:
				if hand[selected_index].cost <= get_parent().energy:
					playCardNoDrink(hand[selected_index])
				else:
					if hand[selected_index]:
						hand[selected_index].set_selected(true, playerId)

func handle_drink_selection_input(event:InputEvent) -> void:
	if avaliable_spots[selectedRow].size() == 0:
		exit_targeting_mode()
		return
	
	if event.is_action_pressed("Select_L_%s" % playerId) and event.device == deviceId or event.is_action_pressed("Left_%s" % playerId) and event.device == deviceId:
		var current_spot = get_active_spot()
		if current_spot != null:
			current_spot.set_selected(false, playerId)

		selected_drink_index = (selected_drink_index + 1) % avaliable_spots[selectedRow].size()

		var new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(true, playerId)
	elif event.is_action_pressed("Select_R_%s" % playerId) and event.device == deviceId or event.is_action_pressed("Right_%s" % playerId) and event.device == deviceId:
		var new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(false, playerId)
			
		if selected_drink_index <= 0:
			selected_drink_index = avaliable_spots[selectedRow].size() - 1 
		else:
			selected_drink_index -= 1
		
		new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(true, playerId)
	
	elif event.is_action_pressed("A_%s" % playerId) and event.device == deviceId:
		var new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(false, playerId)
		play_selected_card()
	
	elif event.is_action_pressed("B_%s" % playerId) and event.device == deviceId:
		var new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(false, playerId)
		if hand[selected_index]:
			hand[selected_index].set_selected(true, playerId)
		exit_targeting_mode()
	elif event.is_action_pressed("Up_%s" % playerId) and event.device == deviceId:
		if selectedRow == 1:
			var new_spot = get_active_spot()
			if new_spot != null:
				new_spot.set_selected(false, playerId)
			
			selectedRow = 0
			selected_drink_index = 0

			new_spot = get_active_spot()
			if new_spot != null:
				new_spot.set_selected(true, playerId)
	elif event.is_action_pressed("Down_%s" % playerId) and event.device == deviceId:
		if selectedRow == 0:
			var new_spot = get_active_spot()
			if new_spot != null:
				new_spot.set_selected(false, playerId)
			selectedRow = 1
			if selected_drink_index >= 2:
				selected_drink_index = 1
			else:
				selected_drink_index = 0
			new_spot = get_active_spot()
			if new_spot != null:
				new_spot.set_selected(true, playerId)
	
func enter_targeting_mode() -> void:
	
	if avaliable_spots.size() == 0:
		print("No drink spots")
		return

	currentState = selectState.SELECTING_DRINK
	if selected_drink_index == -1:
		selected_drink_index = 0
		selectedRow = 0
		
	var spot = get_active_spot()
	if spot != null:
		spot.set_selected(true, playerId)
	elif avaliable_spots[1] and selected_drink_index >= 0 and selected_drink_index < avaliable_spots[1].size():
		selectedRow = 1
		avaliable_spots[1][selected_drink_index].set_selected(true, playerId)
	else:
		hand[selected_index].set_selected(true, playerId)
	
func exit_targeting_mode() -> void:
	currentState = selectState.SELECTING_CARD
	
func play_selected_card() -> void:
	if selected_index == -1 or hand.size() == 0:
		return
		
	var card_to_play = hand[selected_index]
	if card_to_play.cost > get_parent().energy:
		var new_spot = get_active_spot()
		if new_spot != null:
			new_spot.set_selected(true, playerId)
		return
	
	#play card
	useCard(card_to_play)
	if card_to_play.spawnItem:
		var spot = get_active_spot()
		if spot != null:
			var chosen_drink = avaliable_spots[selectedRow][selected_drink_index]
			chosen_drink.apply_card(card_to_play)
	
	hand.remove_at(selected_index)
	
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	discard_tween.tween_property(card_to_play, "global_position", discardPileMarker.global_position, 0.4)
	discard_tween.tween_property(card_to_play, "rotation_degrees", 90, 0.4)
	discard_tween.tween_property(card_to_play, "scale", Vector2(0.5, 0.5), 0.4)
	
	discard_tween.chain().tween_callback(func():
		discardCard(card_to_play)
		)
	
	if hand.size() == 0:
		selected_index = -1
	elif selected_index >= hand.size():
		selected_index = hand.size() - 1
	
	update_hand_layout()
	exit_targeting_mode()

func playCardNoDrink(theCard: Card):
	useCard(theCard)
	hand.remove_at(selected_index)
	discardCard(theCard)
	if hand.size() == 0:
		selected_index = -1
	elif selected_index >= hand.size():
		selected_index = hand.size() - 1
	update_hand_layout()

func useCard(card_to_play:Card):
	get_parent().energy -= card_to_play.cost
	card_to_play.onPlay()
	get_parent().updateEnergy()

func discardCard(card_to_play:Card):
	if card_to_play.limitedUses and card_to_play.uses <= 0:
		card_to_play.queue_free()
	else:
		remove_child(card_to_play)
		discard.append(card_to_play)

func draw_card() -> void:
	var new_card
	if deck.size() > 0:
		new_card = deck.pop_front()
	else:
		deck.append_array(discard)
		discard.clear()
		deck.shuffle()
		
		if deck.size() > 0:
			new_card = deck.pop_front()
		else:
			return

	add_child(new_card)
	new_card.position = Vector2(400, 200)
	
	
	hand.append(new_card)
	update_hand_layout()

func update_hand_layout() -> void:
	var num_cards = hand.size()
	
	for i in range(num_cards):
		var card = hand[i]
		var is_selected = (i == selected_index)
		
		if card.has_method("set_selected"):
			card.set_selected(is_selected, playerId)
			
		var center_offset = i - (num_cards - 1) / 2.0
		
		var target_x = center_offset * spread_distance
		var target_y = pow(center_offset, 2) * height_curve
		var target_rotation = center_offset * rotation_curve
		var target_scale = Vector2.ONE
		
		if is_selected:
			target_y -= 40.0
			target_rotation = 0.0
			target_scale = Vector2(1.2, 1.2)
		
		var tween = create_tween().set_parallel(true)
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		
		tween.tween_property(card, "position", Vector2(target_x, target_y), animation_speed)
		tween.tween_property(card, "rotation_degrees", target_rotation, animation_speed)
		tween.tween_property(card, "scale", target_scale, animation_speed)
	get_parent().updateCardCounts()

#Adds a card to the draw pile. For prepare boba
func addCard(car:Card):
	get_parent().addCard(car)

func addCardToHand(car:Card):
	add_child(car)
	car.position = Vector2(400, 200)
	hand.append(car)
	update_hand_layout()

#only works with delecting a drink spot lol.
func deselect():
	print(selectedRow)
	print(selected_drink_index)
	if selectedRow != -1 and selected_drink_index != -1 and selectedRow < avaliable_spots.size() and selected_drink_index < avaliable_spots[selectedRow].size() and avaliable_spots[selectedRow][selected_drink_index] != null:
		avaliable_spots[selectedRow][selected_drink_index].set_selected(false, playerId)

func get_active_spot():
	if selectedRow >= 0 and selectedRow < avaliable_spots.size():
		if selected_drink_index >= 0 and selected_drink_index < avaliable_spots[selectedRow].size():
			return avaliable_spots[selectedRow][selected_drink_index]
	return null
