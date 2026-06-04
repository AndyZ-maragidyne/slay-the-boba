extends Node2D
class_name StoreShelf

@export var itemPool: Array[PackedScene]
var shopItems = []
var items = []

func _ready() -> void:
	#shuffle()
	displayItems()
	pass
	
func shuffle():
	itemPool.shuffle()
	
func displayItems():
	if itemPool.size() == 3:
		var item1 = itemPool[0].Item.instantiate()
		add_child(item1)
		items.append(item1)
		shopItems.append(itemPool[0])
		item1.position = Vector2(-200, 0)
		var item2 = itemPool[1].Item.instantiate()
		add_child(item2)
		items.append(item2)
		shopItems.append(itemPool[1])
		item2.position = Vector2(0, 0)
		var item3 = itemPool[2].Item.instantiate()
		add_child(item3)
		items.append(item3)
		shopItems.append(itemPool[2])
		item3.position = Vector2(200, 0)
	elif itemPool.size() == 4:
		var item1 = itemPool[0].Item.instantiate()
		add_child(item1)
		items.append(item1)
		shopItems.append(itemPool[0])
		item1.position = Vector2(-300, 0)
		var item2 = itemPool[1].Item.instantiate()
		add_child(item2)
		items.append(item2)
		shopItems.append(itemPool[1])
		item2.position = Vector2(-100, 0)
		var item3 = itemPool[2].Item.instantiate()
		add_child(item3)
		items.append(item3)
		shopItems.append(itemPool[2])
		item3.position = Vector2(100, 0)
		var item4 = itemPool[3].Item.instantiate()
		add_child(item4)
		items.append(item4)
		shopItems.append(itemPool[3])
		item4.position = Vector2(300, 0)
	elif itemPool.size() == 5:
		var item1 = itemPool[0].Item.instantiate()
		add_child(item1)
		items.append(item1)
		shopItems.append(itemPool[0])
		item1.position = Vector2(-400, 0)
		var item2 = itemPool[1].Item.instantiate()
		add_child(item2)
		items.append(item2)
		shopItems.append(itemPool[1])
		item2.position = Vector2(-200, 0)
		var item3 = itemPool[2].Item.instantiate()
		add_child(item3)
		items.append(item3)
		shopItems.append(itemPool[2])
		item3.position = Vector2(0, 0)
		var item4 = itemPool[3].Item.instantiate()
		add_child(item4)
		items.append(item4)
		shopItems.append(itemPool[3])
		item4.position = Vector2(200, 0)
		var item5 = itemPool[4].Item.instantiate()
		add_child(item5)
		items.append(item5)
		shopItems.append(itemPool[4])
		item5.position = Vector2(400, 0)
