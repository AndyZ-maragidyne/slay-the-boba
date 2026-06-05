extends Node

var joinedPlayers: Array[int] = []
var totalCoins = 0
var level = 1
var goal = [5, 10, 15, 20, 30, 40, 50, 65, 80, 100]


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
