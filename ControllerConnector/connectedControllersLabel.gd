extends Label

var connectedControllers:Array[String] = []
var labelText = "Connected Controllers:"

func _ready() -> void:
	text = labelText

func addController(name):
	connectedControllers.append(name)
	updateText()
	
func updateText():
	var output = "Connected Controllers:"
	for c in connectedControllers:
		output += "\n" + c
	text = output
