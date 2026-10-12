extends ShopListing
class_name CardListing

@export var card:CardData = preload("res://Cards/Locked.tres")

var isEmpty:bool = true

func _init(carddata: CardData=null) -> void:
	if carddata:
		card = carddata
		isEmpty = false

func buyItem(playerId:int) -> void:
	if isEmpty:
		globals.mainGame.generateCard(self)
	else:
		var cardReal = Card.create(card)
		globals.getDeck(playerId).append(cardReal)

func stockCard(cardData):
	card = cardData
	isEmpty = false
