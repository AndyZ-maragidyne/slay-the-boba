extends Resource
class_name CardData

@export var cost:int
@export var cardName:String
@export_multiline var description:String
@export var item:PackedScene
@export var limitedUses:bool = false
@export var maxUses:int = -1
@export var spawnItem:bool = false
@export var itemData:Resource
@export var tags:Array[String] = []
@export var selectable = true

func _init() -> void:
	pass

func setDescription():
	pass

func onAbility(card, player) -> void:
	pass
