extends ShopListing
class_name CardListing

@export var card:CardData

func buyItem(playerId:int) -> void:
	globals.getDeck(playerId).append(card)
