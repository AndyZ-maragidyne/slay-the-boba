extends Card

var crystalBobaScene = preload("res://Cards/CrystalBoba.tscn")

func onAbility():
	var hi = crystalBobaScene.instantiate()
	get_parent().discard.append(hi)
