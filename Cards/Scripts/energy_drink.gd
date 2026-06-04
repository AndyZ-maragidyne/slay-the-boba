extends Card

func onAbility():
	get_parent().get_parent().maxEnergy += 1
