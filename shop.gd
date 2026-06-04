extends Node2D


var shopShelves: Array[Array] = []
var shopShelvesData: Array[Array] = []
var upgrades: Array = []
var currentlySelected = []

var PlayerSelections = {
	0: [-1, 0],
	1: [-1, 0],
	2: [-1, 0],
	3: [-1, 0]
}

func _ready() -> void:
	if globals.level > 1:
		currentlySelected.append(PlayerSelections[0].duplicate())
		var s1 = $StoreShelf.shopItems
		var ss1 = $StoreShelf.items
		shopShelvesData.append(s1)
		shopShelves.append(ss1)
		$StoreShelf.visible = true
	if globals.level > 2:
		currentlySelected.append(PlayerSelections[1].duplicate())
		var s2 = $StoreShelf2.shopItems
		var ss2 = $StoreShelf2.items
		shopShelvesData.append(s2)
		shopShelves.append(ss2)
		$StoreShelf2.visible = true
		$lock2.visible = false
	if globals.level > 3:
		currentlySelected.append(PlayerSelections[2].duplicate())
		var s3 = $StoreShelf3.shopItems
		var ss3 = $StoreShelf3.items
		shopShelvesData.append(s3)
		shopShelves.append(ss3)
		$StoreShelf3.visible = true
		$lock3.visible = false
	if globals.level > 4:
		currentlySelected.append(PlayerSelections[3].duplicate())
		var s4 = $StoreShelf4.shopItems
		var ss4 = $StoreShelf4.items
		shopShelvesData.append(s4)
		shopShelves.append(ss4)
		$StoreShelf4.visible = true
		$lock4.visible = false
		

#Keeps track of all the shop shelves and stuff. Keeps track of where each player is selected maybe not actually. When the player seledcts an item, this node is the one that tellls the items that its selected or something idk
func getInput(event:InputEvent, playerId):
	if event.is_action_pressed("Down_%s" % playerId):
		if PlayerSelections[playerId][0] >= shopShelves.size() - 1:
			PlayerSelections[playerId][0] = 0
		else:
			PlayerSelections[playerId][0] += 1
	elif event.is_action_pressed("Up_%s" % playerId):
		if PlayerSelections[playerId][0] <= 0:
			PlayerSelections[playerId][0] = shopShelves.size() -1
		else:
			PlayerSelections[playerId][0] -= 1
	elif event.is_action_pressed("Left_%s" % playerId):
		if PlayerSelections[playerId][1] <= 0:
			PlayerSelections[playerId][1] = shopShelves[PlayerSelections[playerId][0]].size() - 1
		else:
			PlayerSelections[playerId][1] -= 1
	elif event.is_action_pressed("Right_%s" % playerId):
		if PlayerSelections[playerId][1] >= shopShelves[PlayerSelections[playerId][0]].size() - 1:
			PlayerSelections[playerId][1] = 0
		else:
			PlayerSelections[playerId][1] += 1
	
	
	var new_row = PlayerSelections[playerId][0]
	var max_valid_x = shopShelves[new_row].size() - 1

	PlayerSelections[playerId][1] = min(PlayerSelections[playerId][1], max_valid_x)
	reselect(playerId)

func getItemData(playerId):
	return shopShelvesData[currentlySelected[playerId][0]][currentlySelected[playerId][1]]

func reselect(playerId):
	shopShelves[currentlySelected[playerId][0]][currentlySelected[playerId][1]].set_selected(false, playerId)
	currentlySelected[playerId] = PlayerSelections[playerId].duplicate()
	shopShelves[currentlySelected[playerId][0]][currentlySelected[playerId][1]].set_selected(true, playerId)

func startTurn():
	pass
