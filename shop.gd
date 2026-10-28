extends Node2D

enum MenuState { NORMAL, REPLACING_CARD }

var modifierSelection = preload("res://Modifier/modifierSelection.tscn")
@export var cardPool:Array[Resource]
@onready var upgrades = $UpgradesShelf
@onready var shelf = $StoreShelf
@onready var cardReplace = $CardReplacementListing
@onready var playerManager = $Players
var entireShop = []
#var shopShelves: Array[Array] = []
#var shopShelvesData: Array[Array] = []
#var upgrades: Array = []
var playerStates:Dictionary = {}
var currentlySelected = {
	0: [0, 0],
	1: [0, 0],
	2: [0, 0],
	3: [0, 0]
}

var PlayerSelections = {
	0: [0, 0],
	1: [0, 0],
	2: [0, 0],
	3: [0, 0]
}

var buyUpgrades = 0
var buyCards = 1
var buyReplacement = 2
var currentCursorLocation = {
	0: 1,
	1: 1,
	2: 1,
	3: 1
}

var playerCursorLocation = {
	0: 1,
	1: 1,
	2: 1,
	3: 1
}

func _ready() -> void:
	globals.mainGame = self
	for player in globals.joinedPlayers:
		reselect(globals.getPlayerId(player))
	entireShop.append([upgrades.selectableUpgrades])
	entireShop.append(shelf.itemPool)
	entireShop.append([[cardReplace.listing]])

func moveSelection(event: InputEvent, playerId) -> void:
	var current_grid_idx = currentCursorLocation[playerId]
	var current_grid = entireShop[current_grid_idx]
	
	if event.is_action_pressed("Down"):
		if PlayerSelections[playerId][0] >= current_grid.size() - 1:
			PlayerSelections[playerId][0] = 0
		else:
			PlayerSelections[playerId][0] += 1
	elif event.is_action_pressed("Up"):
		if PlayerSelections[playerId][0] <= 0:
			PlayerSelections[playerId][0] = current_grid.size() -1
		else:
			PlayerSelections[playerId][0] -= 1
	elif event.is_action_pressed("Left"):
		if PlayerSelections[playerId][1] <= 0:
			if current_grid_idx > 0:
				playerCursorLocation[playerId] -= 1
				var new_grid = entireShop[playerCursorLocation[playerId]]
				var new_y : int
				if current_grid_idx == buyReplacement and playerCursorLocation[playerId] == buyCards:
					new_y = new_grid.size() - 1 # Force Y to the very bottom row
				else:
					new_y = min(PlayerSelections[playerId][0], new_grid.size() - 1)
					
				PlayerSelections[playerId][0] = new_y
				PlayerSelections[playerId][1] = new_grid[new_y].size() - 1
		else:
			PlayerSelections[playerId][1] -= 1
	elif event.is_action_pressed("Right"):
		if PlayerSelections[playerId][1] >= current_grid[PlayerSelections[playerId][0]].size() - 1:
			if current_grid_idx < entireShop.size() - 1:
				playerCursorLocation[playerId] += 1
				PlayerSelections[playerId][1] = 0
				var new_grid = entireShop[playerCursorLocation[playerId]]
				PlayerSelections[playerId][0] = min(PlayerSelections[playerId][0], new_grid.size() - 1)
		else:
			PlayerSelections[playerId][1] += 1
	else:
		return
	
	var updated_grid_idx = playerCursorLocation[playerId]
	var current_y = PlayerSelections[playerId][0]
	var max_valid_x = entireShop[updated_grid_idx][current_y].size() - 1
	PlayerSelections[playerId][1] = min(PlayerSelections[playerId][1], max_valid_x)
	
	reselect(playerId)

func cardReplaceSelection(event:InputEvent, playerId):
	#playerCursorLocation[playerId] = buyCards
	if event.is_action_pressed("Down"):
		if PlayerSelections[playerId][0] >= shelf.itemPool.size() - 1:
			PlayerSelections[playerId][0] = 0
		else:
			PlayerSelections[playerId][0] += 1
	elif event.is_action_pressed("Up"):
		if PlayerSelections[playerId][0] <= 0:
			PlayerSelections[playerId][0] = shelf.itemPool.size() -1
		else:
			PlayerSelections[playerId][0] -= 1
	elif event.is_action_pressed("Left"):
		if PlayerSelections[playerId][1] <= 0:
			PlayerSelections[playerId][1] = shelf.itemPool[PlayerSelections[playerId][0]].size() - 1
		else:
			PlayerSelections[playerId][1] -= 1
	elif event.is_action_pressed("Right"):
		if PlayerSelections[playerId][1] >= shelf.itemPool[PlayerSelections[playerId][0]].size() - 1:
			PlayerSelections[playerId][1] = 0
		else:
			PlayerSelections[playerId][1] += 1
	
	
	var new_row = PlayerSelections[playerId][0]
	var max_valid_x = shelf.itemPool[new_row].size() - 1

	PlayerSelections[playerId][1] = min(PlayerSelections[playerId][1], max_valid_x)
	var cardLocation = shelf.getCard(PlayerSelections[playerId][0], PlayerSelections[playerId][1])
	var player = globals.mainGame.playerManager.activePlayers[globals.joinedPlayers[playerId]]
	player.holdingReplacingCardReal.position = cardLocation.global_position
	reselect(playerId)

func reselect(playerId):
	if currentCursorLocation[playerId] == buyCards:
		shelf.setSelected(playerId, currentlySelected[playerId][0], currentlySelected[playerId][1], false)
	elif currentCursorLocation[playerId] == buyReplacement:
		cardReplace.setSelected(playerId, false)
	elif currentCursorLocation[playerId] == buyUpgrades:
		upgrades.setSelected(playerId, currentlySelected[playerId][0], currentlySelected[playerId][1], false)
	
	var change = 0
	if currentCursorLocation[playerId] != playerCursorLocation[playerId]:
		change = playerCursorLocation[playerId] - currentCursorLocation[playerId]
		currentCursorLocation[playerId] = playerCursorLocation[playerId]

	if currentCursorLocation[playerId] == buyCards:
		if change == 1:
			currentlySelected[playerId] = [0, PlayerSelections[playerId][1]]
		elif change == -1: 
			currentlySelected[playerId] = PlayerSelections[playerId].duplicate()
		else:
			currentlySelected[playerId] = PlayerSelections[playerId].duplicate()
		shelf.setSelected(playerId, currentlySelected[playerId][0], currentlySelected[playerId][1], true)
	elif currentCursorLocation[playerId] == buyReplacement:
		currentlySelected[playerId] = [0, 0]
		cardReplace.setSelected(playerId, true)
	elif currentCursorLocation[playerId] == buyUpgrades:
		if change == -1:
			currentlySelected[playerId] = [0, 0]
		currentlySelected[playerId] = PlayerSelections[playerId].duplicate()
		upgrades.setSelected(playerId, currentlySelected[playerId][0], currentlySelected[playerId][1], true)

#gets the shop listing of the item that that the player is hovering over
func getItemData(playerId):
	return entireShop[currentCursorLocation[playerId]][currentlySelected[playerId][0]][currentlySelected[playerId][1]]

func startTurn():
	pass

func generateCard(listing):
	var randomIndex = randi() % cardPool.size()
	var card = cardPool.pop_at(randomIndex)
	listing.stockCard(card)
	listing.price = randi_range(10, 17)
	shelf.displayItems()
	for player in globals.joinedPlayers:
		reselect(globals.getPlayerId(player))
