extends CardData
class_name CardOvertime

func onAbility(card, player):
	globals.mainGame.extendTime(5)
