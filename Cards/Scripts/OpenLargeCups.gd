extends CardData
class_name CardOpenLargeCups

var largeCupScene = preload("res://Cards/LargeCup.tres")

func onAbility(card, player):
	var hi = Card.create(largeCupScene)
	player.getHand().addCardToHand(hi)
