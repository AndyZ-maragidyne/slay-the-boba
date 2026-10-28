extends CardData
class_name AddCardToHand

@export var cardScene = preload("res://Cards/MilkyTea.tres")
@export var amount = 1

func onAbility(card, player):
	for i in amount:
		var hi = Card.create(cardScene)
		player.getHand().addCardToHand(hi)
