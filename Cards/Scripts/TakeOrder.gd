extends CardData
class_name CardTakeOrder

func onAbility(card, player):
	globals.mainGame.get_node("Drinks").addOrder()
	globals.mainGame.get_node("Drinks").update_drink_layout()
