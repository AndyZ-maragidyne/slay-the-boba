extends ShopListing
class_name UpgradeListing

var upgrade
var upgradeReal
func _init(upgradeData = null) -> void:
	if upgradeData != null:
		upgrade = upgradeData
		upgradeReal = upgradeData.instantiate()

func buyItem(playerId):
	upgradeReal.clicked(playerId)
	pass
