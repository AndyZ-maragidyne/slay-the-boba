extends Node

var joinedPlayers: Array[int] = []
var totalCoins = 0
var level = 1
var goal = [5, 10, 15, 20, 30, 40, 50, 65, 80, 100]
var menu = Menu.new(3)
var unlockedCardPool: Array[Array]
var modifiers = []
#Root node of the scene
var mainGame

var playerDecks = {
	0: [],
	1: [],
	2: [],
	3: []
}

var playerData: Array[PlayerData] = [PlayerData.new(), PlayerData.new(), PlayerData.new(), PlayerData.new()]

var bobaMachineProgress = 0

func _ready() -> void:
	setupUnlockedCards()
	
func setupUnlockedCards():
	var smallCup = preload("res://Cards/OpenSmallCups.tres")
	var milkytea = preload("res://Cards/MilkTeaPowder.tres")
	var boba = preload("res://Cards/InstantBobaPacket.tres")
	unlockedCardPool = [[CardListing.new(smallCup), CardListing.new(milkytea), CardListing.new(boba), CardListing.new()], [CardListing.new(), CardListing.new(), CardListing.new(), CardListing.new()], [CardListing.new(), CardListing.new(), CardListing.new(), CardListing.new()], [CardListing.new(), CardListing.new(), CardListing.new(), CardListing.new()]]


func getDeck(playerId):
	return playerDecks[playerId]

func getGoal():
	var output
	if level > 10:
		output = 100 + (20 * (level - 6))
	else:
		output = goal[level - 1]
	return output

func getTimeLeft():
	if level == 1:
		return 5
	else:
		return 10 

#returns index at where the deviceId is found
func getPlayerId(deviceId):
	var index = 0
	for id in joinedPlayers:
		if id == deviceId:
			return index
		index += 1
	return null

func getNumPlayers():
	return joinedPlayers.size()

#Persistence keys
var broom_upgrade = false
