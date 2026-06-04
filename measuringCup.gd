extends Node2D

@onready var borderRed: ReferenceRect = $BorderRed
@onready var borderBlue: ReferenceRect = $BorderBlue
@onready var borderYellow: ReferenceRect = $BorderYellow
@onready var borderGreen: ReferenceRect = $BorderGreen

var storedCards: Array[Card] = []
var isReady = false
var isCorrect = false
func _ready() -> void:
	borderRed.visible = false
	borderBlue.visible = false
	borderYellow.visible = false
	borderGreen.visible = false

func set_selected(is_selected: bool, playerId) -> void:
	match playerId:
		0:
			borderRed.visible = is_selected
		1:
			borderBlue.visible = is_selected
		2:
			borderYellow.visible = is_selected
		3:
			borderGreen.visible = is_selected

func apply_card(c: Card):
	var car = c.duplicate()
	add_child(car)
	car.global_position = global_position
	storedCards.append(car)
	applyMix()
	pass

func applyMix():
	#if first thing is milk and second is tea OR vice versa, make a milk tea
	if (storedCards.size() >= 2) and (storedCards[0].itemData.liquidType == ItemData.LiquidType.MILK and storedCards[1].itemData.liquidType == ItemData.LiquidType.TEA or storedCards[0].itemData.liquidType == ItemData.LiquidType.TEA and storedCards[1].itemData.liquidType == ItemData.LiquidType.MILK):
		var outputScene = preload("res://Cards/MilkTea.tscn")
		var output = outputScene.instantiate()
		storedCards[0].queue_free()
		storedCards[1].queue_free()
		#Here in case someone puts more than 2 things in the cup. We really need to improve this entire code for the mixing cup in the future
		for s in storedCards:
			s.queue_free()
		storedCards.clear()
		add_child(output)
		storedCards.append(output)
		output.global_position = global_position
		isReady = true
		isCorrect = true
	elif storedCards.size() >= 2:
		isReady = true

func grabDrink():
	if isReady and isCorrect:
		var card = storedCards[0].duplicate()
		storedCards[0].queue_free()
		storedCards.clear()
		isReady = false
		return card
	elif isReady:
		for s in storedCards:
			s.queue_free()
		storedCards.clear()
		isReady = false

func setColor(Color):
	$Color.color = Color
	$Color.visible = true
