extends Node2D

@onready var borderRed: ReferenceRect = $BorderRed
@onready var borderBlue: ReferenceRect = $BorderBlue
@onready var borderYellow: ReferenceRect = $BorderYellow
@onready var borderGreen: ReferenceRect = $BorderGreen

var itemDatas: Array[ItemData] = []
var placedItems:Array = []

func _ready() -> void:
	borderRed.visible = false
	borderBlue.visible = false
	borderYellow.visible = false
	borderGreen.visible = false

func set_selected(is_selected: bool, deviceId) -> void:
	match deviceId:
		0:
			borderRed.visible = is_selected
		1:
			borderBlue.visible = is_selected
		2:
			borderYellow.visible = is_selected
		3:
			borderGreen.visible = is_selected

func apply_card(card:Card) -> void:
	if card.item != null:
		var newItem = card.item.instantiate()
		add_child(newItem)
		placedItems.append(newItem)
		itemDatas.append(card.itemData)
		newItem.position = $SpawnPoint.position
	elif card.itemData.category == ItemData.Category.LIQUID:
		var index = 0
		for i in itemDatas:
			if i.category == ItemData.Category.CUP:
				placedItems[index].setColor(card.itemData.color)
				return
			index += 1
		pass
	else:
		print("card does not have an item to spawn")
