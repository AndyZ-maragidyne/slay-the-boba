extends Node2D

const drinkScene = preload("res://drink.tscn")
var drinkSpots: Array[Node]

var score = 0

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
	var targetPositions = [
		Vector2(1612, 378),
		Vector2(1179, 378),
		Vector2(737, 378),
		Vector2(271, 378)
	]
	var slide_time: float = 0.5
	var discard_tween = create_tween().set_parallel(true)
	discard_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	for i in range(4):
		if i >= drinkSpots.size():
			break
		var targetPos = targetPositions[i]
		var drink = drinkSpots[i]
		var uiStuff = drink.get_node("Stuff")
		discard_tween.tween_property(uiStuff, "global_position", targetPos, 0.4)
		
		var items = drink.get_children()
		for asdf in items:
			var rigidbodies = asdf.get_children()
			for item in rigidbodies:
				if item is RigidBody2D:
					var distance_to_move: Vector2 = targetPos - item.global_position
					var required_velocity: Vector2 = distance_to_move / slide_time
				
					item.gravity_scale = 0.0
					item.linear_velocity = Vector2(required_velocity.x, 1)
		get_tree().create_timer(slide_time).timeout.connect(func():
			for asdf in items:
				var rigidbodies = asdf.get_children()
				for item in rigidbodies:
					if item is RigidBody2D:
						item.linear_velocity = Vector2.ZERO
						item.gravity_scale = 1.0
		)
	#discard_tween.tween_property(drinkSpots[0], "position", Vector2(1612, 378), 0.4)
	#discard_tween.tween_property(drinkSpots[1], "position", Vector2(1179, 378), 0.4)
	#discard_tween.tween_property(drinkSpots[2], "position", Vector2(737, 378), 0.4)
	#discard_tween.tween_property(drinkSpots[3], "position", Vector2(271, 378), 0.4)
	pass

func sendOrder():
	#grab the first thing in the list
	#see how much it scores
	var drink = drinkSpots.pop_front()
	var drinkScore = drink.scoreDrink()
	score += drinkScore
	get_parent().get_node("Score").text = "Score: " + str(score)
	drink.queue_free()
	addOrder()
	update_drink_layout()
