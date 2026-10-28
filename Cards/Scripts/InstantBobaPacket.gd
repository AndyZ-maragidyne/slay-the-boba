extends CardData
class_name CardInstantBobaPacket

var instantTapiocaScene = preload("res://Cards/InstantTapioca.tres")

func onAbility(card, player):
	var hi = Card.create(instantTapiocaScene)
	player.getHand().addCardToHand(hi)
