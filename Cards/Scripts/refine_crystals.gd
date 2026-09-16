extends CardData
class_name CardRefineCrystals

var crystalBobaScene = preload("res://Cards/CrystalBoba.tres")
#TODO IF IT CRASHES HERE FIX. since we dont have crystal boba cards anymore and I didnt test the new solution

func onAbility(card, player):
	var hi = Card.create(crystalBobaScene)
	player.getHand().discard.append(hi)
