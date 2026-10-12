extends Upgrade

func clicked(playerId):
	upgradeCleanCards()
	
func upgradeCleanCards():
	var cleanCard = preload("res://Cards/Clean.tres")
	cleanCard.cleanValue *= 2
	for deck in globals.playerDecks:
		for card in globals.playerDecks[deck]:
			if "clean" in card.tags:
				card.data.setDescription()
				card.reloadUI()
	
	globals.broom_upgrade = true
	pass
