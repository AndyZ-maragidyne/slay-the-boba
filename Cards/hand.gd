extends Node2D

@export var card_scene:PackedScene

@export var spread_distance:float = 80.0
@export var height_curve:float = 12.0
@export var rotation_curve:float = 6.0
@export var animation_speed:float = 0.3

enum selectState { SELECTING_CARD, SELECTING_DRINK }
var currentState: selectState = selectState.SELECTING_CARD

var deviceId
var hand: Array[Node2D]
var deck: Array[Node2D]
var discard: Array[Node2D]
var selected_index = -1

var avaliable_spots: Array[Node]
var selected_drink_index = -1

@onready var player = get_parent()
@onready var discardPileMarker: Node2D = $DiscardPile

func _ready() -> void:
	if get_parent():
		deviceId = get_parent().deviceId
		hand = get_parent().hand
		deck = get_parent().deck
		discard = get_parent().discard
	avaliable_spots =  get_node("../../../Drinks").drinkSpots

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_card()
	
	if hand.size() == 0 or player.endTurn:
		return
	
	if currentState == selectState.SELECTING_CARD:
		handle_card_selection_input(event)
	elif currentState == selectState.SELECTING_DRINK:
		handle_drink_selection_input(event)
	
func handle_card_selection_input(event:InputEvent) -> void:
	if event.is_action_pressed("Select_R_%s" % deviceId):
		selected_index = (selected_index + 1) % hand.size()
		update_hand_layout()
		
	elif event.is_action_pressed("Select_L_%s" % deviceId):
		if selected_index <= 0:
			selected_index = hand.size() - 1
		else:
			selected_index -= 1
		update_hand_layout()
	
	elif event.is_action_pressed("A_%s" % deviceId) and selected_index != -1:
		if hand[selected_index]:
			hand[selected_index].set_selected(false, deviceId)
		enter_targeting_mode()

func handle_drink_selection_input(event:InputEvent) -> void:
	if avaliable_spots.size() == 0:
		exit_targeting_mode()
		return
	
	if event.is_action_pressed("Select_L_%s" % deviceId):
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(false, deviceId)
			
		selected_drink_index = (selected_drink_index + 1) % avaliable_spots.size()
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(true, deviceId)
			
	elif event.is_action_pressed("Select_R_%s" % deviceId):
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(false, deviceId)
			
		if selected_drink_index <= 0:
			selected_drink_index = avaliable_spots.size() - 1 
		else:
			selected_drink_index -= 1
		
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(true, deviceId)
	
	elif event.is_action_pressed("A_%s" % deviceId):
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(false, deviceId)
		play_selected_card()
	
	elif event.is_action_pressed("B_%s" % deviceId):
		if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(false, deviceId)
		if hand[selected_index]:
			hand[selected_index].set_selected(true, deviceId)
		exit_targeting_mode()

func enter_targeting_mode() -> void:
	
	if avaliable_spots.size() == 0:
		print("No drink spots")
		return
	
	currentState = selectState.SELECTING_DRINK
	if selected_drink_index == -1:
		selected_drink_index = 0
	if avaliable_spots[selected_drink_index]:
			avaliable_spots[selected_drink_index].set_selected(true, deviceId)
	
func exit_targeting_mode() -> void:
	currentState = selectState.SELECTING_CARD

#lol am I using this?	
#func update_reticle_position() -> void:
	#if not reticle or available_spots.size() == 0: return
	#
	#var target_spot = available_spots[selected_spot_index] as Node2D
	#
	## Smoothly slide a targeting reticle/arrow to the active spot's position
	#var tween = create_tween()
	#tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	## global_position maps coordinates accurately regardless of where the HandManager is located
	#tween.tween_property(reticle, "global_position", target_spot.global_position, 0.15)
	
func play_selected_card() -> void:
	if selected_index == -1 or hand.size() == 0:
		return
		
	var card_to_play = hand[selected_index]
	var chosen_drink = avaliable_spots[selected_drink_index]
	
	chosen_drink.apply_card(card_to_play)
	
	hand.remove_at(selected_index)
	
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	discard_tween.tween_property(card_to_play, "global_position", discardPileMarker.global_position, 0.4)
	discard_tween.tween_property(card_to_play, "rotation_degrees", 90, 0.4)
	discard_tween.tween_property(card_to_play, "scale", Vector2(0.5, 0.5), 0.4)
	
	discard_tween.chain().tween_callback(func():
		remove_child(card_to_play)
		discard.append(card_to_play)
		)
	
	if hand.size() == 0:
		selected_index = -1
	elif selected_index >= hand.size():
		selected_index = hand.size() - 1
	
	update_hand_layout()
	exit_targeting_mode()
	
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
			card.set_selected(is_selected, deviceId)
			
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
