extends CardData
class_name CardClean

func onAbility(card, player):
	globals.mainGame.modifyRep(5)
	card.modifyCost(1)
