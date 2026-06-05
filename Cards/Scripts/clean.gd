extends Card

func onAbility():
	cost += 1
	get_parent().get_parent().get_parent().get_parent().modifyRep(5)
	$Cost.text = str(cost)
