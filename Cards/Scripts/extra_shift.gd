extends CardData
class_name CardExtraShift

func onAbility(card, player):
	globals.mainGame.extendTime(2)
