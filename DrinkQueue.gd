extends Node2D

const drinkScene = preload("res://drink.tscn")
var drinkSpots: Array[Node]

func _ready() -> void:
	addOrder()
	addOrder()
	addOrder()
	addOrder()
	update_drink_layout()

func addOrder():
	var drink = drinkScene.instantiate()
	add_child(drink)
	drinkSpots.append(drink)

func update_drink_layout():
	#drinkSpots[0].position = Vector2(1612, 378)
	#drinkSpots[1].position = Vector2(1179, 378)
	#drinkSpots[2].position = Vector2(737, 378)
	#drinkSpots[3].position = Vector2(271, 378)
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	discard_tween.tween_property(drinkSpots[0], "position", Vector2(1612, 378), 0.4)
	discard_tween.tween_property(drinkSpots[1], "position", Vector2(1179, 378), 0.4)
	discard_tween.tween_property(drinkSpots[2], "position", Vector2(737, 378), 0.4)
	discard_tween.tween_property(drinkSpots[3], "position", Vector2(271, 378), 0.4)
	pass

func sendOrder():
	#grab the first thing in the list
	#see how much it scores
	var drink = drinkSpots.pop_front()
	#scoring
	drink.queue_free()
	addOrder()
	update_drink_layout()
