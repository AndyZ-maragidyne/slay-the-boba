extends Resource
class_name CardData

@export var cost:int
@export var cardName:String
@export_multiline var description:String
@export var item:PackedScene
@export var limitedUses:bool = false
@export var maxUses:int = -1
@export var spawnItem:bool = true
@export var itemData:Resource

func onAbility(card, player) -> void:
	pass
