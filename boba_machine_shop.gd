extends Node2D

var prepareBoba = preload("res://Cards/Prepare Boba.tscn")

func onBuy():
	globals.bobaMachineProgress += 1
	if globals.bobaMachineProgress >= globals.joinedPlayers:
		var hi = ShopItem.new()
		hi.cost = 5
		hi.card = true
		hi.Item = prepareBoba
		get_parent().replaceWith(hi, self)
