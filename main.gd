extends Node2D

var timeLeft = 10
var coins = 0
var rep = 0
var repGoal = 5
var firstTurn = true
var turnsSinceFirst = 0
var orderAutoSending = false

func _ready():
	setup()
	#$Progress.setProgress(repGoal)
	#$Progress.updateProgress(rep)
	#repGoal = globals.getGoal()
	#$Score.text = "Goal: " + str(repGoal)
	#timeLeft = globals.getTimeLeft()
	#$TimeLeft.text = "Time Left: " + str(timeLeft)
	pass

func setup():
	var numPlayers = $Players.activePlayers.size()
	print(numPlayers)
	repGoal = globals.getGoal() * numPlayers
	print(repGoal)
	$Progress.setProgress(repGoal)
	$Progress.updateProgress(rep)
	
	$Score.text = "Goal: " + str(repGoal)
	timeLeft = globals.getTimeLeft()
	$TimeLeft.text = "Time Left: " + str(timeLeft)
	startTurn()
	
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
		var random_player = allPlayers.pick_random()
		var cardScene = preload("res://Cards/TakeOrderStartingHand.tscn")
		var card = cardScene.instantiate()
		random_player.get_node("Hand").addCardToHand(card)
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
	if turnsSinceFirst >= 2:
		modifyOrderAutoSending(true)
	if timeLeft == 0:
		endDay()
	else:
		$TimeLeft.text = "Time Left: " + str(timeLeft)
		startTurn()

func endDay():
	for d in $Drinks.drinkSpots:
		await get_tree().create_timer(0.6).timeout
		$Drinks.sendOrder()
	await get_tree().create_timer(0.6).timeout
	var coinsSplit = coins / $Players.activePlayers.size()
	if rep >= repGoal:
		var allPlayers = $Players.get_children()
		for p in allPlayers:
			p.coins += coinsSplit
			globals.playerData[p.playerId] = p.convertToData()
		globals.totalCoins += coinsSplit
		globals.level += 1
		get_tree().change_scene_to_file("res://shop.tscn")
	else:
		var zero = 0
		1/zero
	pass

func extendTime(time:int):
	timeLeft += time
	$TimeLeft.text = "Time Left: " + str(timeLeft)

func modifyRep(value:int):
	rep += value
	$Progress.updateProgress(rep)

func modifyCoins(value:int):
	coins += value
	$Coins.text = "Coins: " + str(coins)

func modifyOrderAutoSending(value:bool):
	orderAutoSending = value
	$AutosendWarning.visible = value
