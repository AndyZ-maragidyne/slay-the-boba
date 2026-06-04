extends Card

func onAbility():
	get_parent().get_parent().get_parent().get_parent().get_node("Drinks").addOrder()
	get_parent().get_parent().get_parent().get_parent().get_node("Drinks").update_drink_layout()
