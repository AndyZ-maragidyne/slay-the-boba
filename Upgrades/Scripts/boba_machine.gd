extends Upgrade


var prepareBoba = preload("res://Cards/PrepareBoba.tres")
var purchased = false


func clicked(playerId):
	if !purchased:
		onBuy()
	else:
		onClick(playerId)

func onBuy():
	purchased = true
	pass

func onClick(playerId):
	globals.getDeck(playerId).append(prepareBoba)
	pass
