extends CardData
class_name CardPrepareBoba

var BobaScene = preload("res://Cards/boba.tres")
#TODO FIX if it still dosent work. this dosent exist anymore

func onAbility(card, player):
	var boba = Card.create(BobaScene)
	player.getHand().addCard(boba)
	var boba2 = Card.create(BobaScene)
	player.getHand().addCard(boba2)
	player.getHand().deck.shuffle()
