extends Node2D

var timeLeft = 10
var coins = 0
var rep = 0
var repGoal = 5
var firstTurn = true
var turnsSinceFirst = 0
var orderAutoSending = false

func _ready():
	$Progress.setProgress(repGoal)
	$Progress.updateProgress(rep)
	$Score.text = "Goal: " + str(repGoal)
	pass

func startTurn():
	#get all the players make them all draw cards
	var allPlayers = $Players.get_children()
	for p in allPlayers:
		if p.hand.size() > 0:
			for c in p.hand:
				p.get_node("Hand").remove_child(c)
			p.discard.append_array(p.hand)
			p.hand.clear()

		
		p.endTurn = false
		p.get_node("Hand").draw_card()
		p.get_node("Hand").draw_card()
		p.get_node("Hand").draw_card()
		p.get_node("Hand").draw_card()
		p.get_node("Hand").draw_card()
		p.updateCardCounts()
		p.resetEnergy()
		if firstTurn:
			var cardScene = preload("res://Cards/TakeOrderStartingHand.tscn")
			var card = cardScene.instantiate()
			p.get_node("Hand").addCardToHand(card)
			firstTurn = false
	$Players.setPlayerPositions()

func checkEndTurn():
	var allPlayers = $Players.get_children()
	var nextTurn = true
	for p in allPlayers:
		if !p.endTurn:
			nextTurn = false
			break
	if nextTurn:
		endTurn()

func endTurn():
	if orderAutoSending:
		$Drinks.sendOrder()
	timeLeft -= 1
	turnsSinceFirst += 1
	if turnsSinceFirst >= 3:
		modifyOrderAutoSending(true)
	if timeLeft == 0:
		endDay()
	else:
		$TimeLeft.text = "Time Left: " + str(timeLeft)
		startTurn()

func endDay():
	if rep >= repGoal:
		var allPlayers = $Players.get_children()
		for p in allPlayers:
			p.coins += coins
			globals.playerData[p.playerId] = p.convertToData()
		globals.totalCoins += coins
		globals.level += 1
		get_tree().change_scene_to_file("res://shop.tscn")
	else:
		var zero = 0
		1/zero
	pass

func extendTime(time:int):
	timeLeft += time

func modifyRep(value:int):
	rep += value
	$Progress.updateProgress(rep)

func modifyCoins(value:int):
	coins += value
	$Coins.text = "Coins: " + str(coins)

func modifyOrderAutoSending(value:bool):
	orderAutoSending = value
	$AutosendWarning.visible = value
