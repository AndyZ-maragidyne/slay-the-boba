extends CardData
class_name CardOpenSmallCups

var smallCupScene = preload("res://Cards/SmallCup.tres")

func onAbility(card, player):
	var hi = Card.create(smallCupScene)
	player.getHand().addCardToHand(hi)
	hi = Card.create(smallCupScene)
	player.getHand().addCardToHand(hi)
	hi = Card.create(smallCupScene)
	player.getHand().addCardToHand(hi)
