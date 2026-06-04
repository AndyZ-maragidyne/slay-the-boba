extends Node

var joinedPlayers: Array[int] = []
var totalCoins = 0
var level = 1
var goal = [5, 10, 20, 30, 40, 50]


var playerDecks = {
	0: [],
	1: [],
	2: [],
	3: []
}

var playerData: Array[PlayerData] = [PlayerData.new(), PlayerData.new(), PlayerData.new(), PlayerData.new()]

var bobaMachineProgress = 0

func getDeck(playerId):
	return playerDecks[playerId]

func getGoal():
	var output
	if level > 6:
		output = 50 + (10 * (level - 6))
	else:
		output = goal[level - 1]
	return output
