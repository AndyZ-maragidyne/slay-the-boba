extends CardData
class_name CardEnergyDrink

func onAbility(card, player):
	player.maxEnergy += 1
