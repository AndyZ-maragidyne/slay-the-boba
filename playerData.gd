extends Resource
class_name PlayerData
@export var maxEnergy: int
@export var coins:int

func _init(pMaxEnergy = 3, pCoins = 0) -> void:
	maxEnergy = pMaxEnergy
	coins = pCoins
