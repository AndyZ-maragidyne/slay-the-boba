extends CharacterBody2D

@export var deviceId: int = 0
@export var playerId: int

var endTurn: bool = false

var deck: Array[Node2D] = []
var hand: Array[Node2D] = []
var discard: Array[Node2D] = []

var smallCup = preload("res://Cards/SmallCup.tscn")
var mediumCup = preload("res://Cards/MediumCup.tscn")
var largeCup = preload("res://Cards/LargeCup.tscn")
var boba = preload("res://Cards/boba.tscn")
var water = preload("res://Cards/Water.tscn")
func _ready() -> void:
	var new_card = smallCup.instantiate()
	deck.append(new_card)
	new_card = smallCup.instantiate()
	deck.append(new_card)
	new_card = mediumCup.instantiate()
	deck.append(new_card)
	new_card = mediumCup.instantiate()
	deck.append(new_card)
	new_card = largeCup.instantiate()
	deck.append(new_card)
	new_card = boba.instantiate()
	deck.append(new_card)
	new_card = water.instantiate()
	deck.append(new_card)
	
	
func addCard(card):
	deck.append(card)

func shuffle():
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X_%s" % playerId) and event.device == deviceId:
		#send order
		get_parent().get_parent().get_node("Drinks").sendOrder()
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
			)
			
		else:
			get_parent().setPlayerPositions()
