extends CardData
class_name AddCardToDraw

@export var cardScene = preload("res://Cards/MilkyTea.tres")
@export var amount = 1

func onAbility(card, player):
	for i in amount:
		var boba = Card.create(cardScene)
		player.getHand().addCard(boba)
	player.getHand().deck.shuffle()
