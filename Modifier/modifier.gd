extends Resource
class_name Modifier

@export var title:String
@export_multiline var description:String 
@export var temporary:bool = false
@export var numRounds:int = 0

#Use globals.mainGame
func onStartTurn():
	pass

func onStartDay():
	pass

func onNewOrder():
	pass

func onDrinkUpdate(drink):
	pass

func onCardPlay():
	pass

#Called at the end of the day.
#Returns true if modifier should me removed from the array
func endOfDay():
	if temporary:
		numRounds -= 1
		if numRounds == 0:
			return true
