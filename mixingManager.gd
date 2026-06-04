extends Node2D


var measuringCupScene = preload("res://measuring_cup.tscn")
var mixingSpots: Array[Node]

func _ready() -> void:
	addSpot()
	addSpot()
	updateLayout()

func addSpot():
	var mc = measuringCupScene.instantiate()
	add_child(mc)
	mixingSpots.append(mc)
	

func updateLayout():
	var targetPositions = [
		Vector2(1400, 625),
		Vector2(675, 625),
		#Vector2(737, 378),
		#Vector2(271, 378)
	]
	
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	discard_tween.tween_property(mixingSpots[0], "position", targetPositions[0], 0.4)
	discard_tween.tween_property(mixingSpots[1], "position", targetPositions[1], 0.4)
	#discard_tween.tween_property(drinkSpots[2], "position", Vector2(737, 378), 0.4)
	#discard_tween.tween_property(drinkSpots[3], "position", Vector2(271, 378), 0.4)
