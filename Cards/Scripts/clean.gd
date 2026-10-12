extends CardData
class_name CardClean

var cleanValue = 5

func _init() -> void:
	super()
	if globals.broom_upgrade == true:
		cleanValue *= 2
	tags.append("clean")
	setDescription()

func setDescription():
	description = "Increase Rep by " + str(cleanValue) + "\nIncrease cost by 1"

func onAbility(card, player):
	globals.mainGame.modifyRep(cleanValue)
	card.modifyCost(1)
