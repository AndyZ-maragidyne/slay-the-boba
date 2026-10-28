extends CardData
class_name CardMeasuringCup

func onAbility(card, player):
	var spot = globals.mainGame.get_node("Drinks").addItem()
	globals.mainGame.get_node("Drinks").update_drink_layout()
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		await tree.create_timer(0.5).timeout
	spot.apply_card(card)
