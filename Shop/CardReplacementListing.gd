extends ShopListing
class_name CardReplacementListing

var card

func buyItem(playerId:int) -> void:
	globals.mainGame.generateCard(self)
	globals.mainGame.playerStates[playerId] = globals.mainGame.MenuState.REPLACING_CARD
	globals.mainGame.PlayerSelections[playerId] = [0,0]
	globals.mainGame.playerCursorLocation[playerId] = globals.mainGame.buyCards
	globals.mainGame.reselect(playerId)
	var player = globals.mainGame.playerManager.activePlayers[globals.joinedPlayers[playerId]]
	player.holdingReplacingCard = card
	var item = Card.create(card)
	globals.mainGame.add_child(item)
	item.z_index = 10
	item.scale = Vector2(1.3, 1.3)
	player.holdingReplacingCardReal = item
	var cardLocation = globals.mainGame.shelf.getCard(globals.mainGame.PlayerSelections[playerId][0], globals.mainGame.PlayerSelections[playerId][1])
	item.global_position = cardLocation.global_position


func stockCard(cardData):
	card = cardData
