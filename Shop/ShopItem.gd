extends Node2D

class_name ShopItem

@export var cost: int
@export var card: bool = true
@export var Item:PackedScene

func _ready() -> void:
	$Cost.text = "$" + str(cost)
	var asdf = Item.instantiate()
	add_child(asdf)
