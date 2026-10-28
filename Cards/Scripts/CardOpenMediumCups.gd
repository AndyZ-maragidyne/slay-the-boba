extends CardData
class_name CardOpenMediumCups

var mediumCupScene = preload("res://Cards/MediumCup.tres")

func onAbility(card, player):
	var hi = Card.create(mediumCupScene)
	player.getHand().addCardToHand(hi)
	hi = Card.create(mediumCupScene)
	player.getHand().addCardToHand(hi)
