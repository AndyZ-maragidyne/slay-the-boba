extends Card

func onAbility():
	get_parent().get_parent().energy += 1
	get_parent().get_parent().get_parent().get_parent().modifyRep(-5)
