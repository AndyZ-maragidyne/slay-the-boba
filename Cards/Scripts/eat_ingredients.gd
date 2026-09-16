extends CardData
class_name CardEatIngredients

func onAbility(card, player):
	player.energy += 1
	globals.mainGame.modifyRep(-5)
