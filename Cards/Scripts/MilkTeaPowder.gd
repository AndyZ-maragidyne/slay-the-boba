extends CardData
class_name CardMilkTeaPowder

var milkyTeaScene = preload("res://Cards/MilkyTea.tres")

func onAbility(card, player):
	var hi = Card.create(milkyTeaScene)
	player.getHand().addCardToHand(hi)
	hi = Card.create(milkyTeaScene)
	player.getHand().addCardToHand(hi)
