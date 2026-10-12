extends Modifier


var dayStarted = false

func onStartTurn():
	if dayStarted:
		var allPlayers = globals.mainGame.get_node("Players").get_children()
		for p in allPlayers:
			p.get_node("Hand").draw_card()
			p.get_node("Hand").draw_card()
		dayStarted = false

func onStartDay():
	dayStarted = true
