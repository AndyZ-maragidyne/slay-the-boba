extends Card

var BobaScene = preload("res://Cards/boba.tscn")

func onAbility():
	var boba = BobaScene.instantiate()
	get_parent().addCard(boba)
	var boba2 = BobaScene.instantiate()
	get_parent().addCard(boba2)
	get_parent().deck.shuffle()
