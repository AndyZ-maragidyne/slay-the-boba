extends CardData
class_name AddCardToDiscard

@export var cardScene = preload("res://Cards/MilkyTea.tres")
@export var amount = 1

func onAbility(card, player):
	for i in amount:
		var boba = Card.create(cardScene)
		player.getHand().discard.append(boba)
