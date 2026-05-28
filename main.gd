extends Node2D


func ready():
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
	$Players.setPlayerPositions()

func checkEndTurn():
	var allPlayers = $Players.get_children()
	var nextTurn = true
	for p in allPlayers:
		if !p.endTurn:
			nextTurn = false
			break
	if nextTurn:
		startTurn()
