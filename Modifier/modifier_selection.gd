extends Node2D

var modifier1
var modifier2
var leftChoice:Array[int]
var rightChoice:Array[int]

@onready var Red = $UI/BorderRed
@onready var Red2 = $UI/BorderRed2
@onready var Yellow = $UI/BorderYellow
@onready var Yellow2 = $UI/BorderYellow2
@onready var Blue = $UI/BorderBlue
@onready var Blue2 = $UI/BorderBlue2
@onready var Green = $UI/BorderGreen
@onready var Green2 = $UI/BorderGreen2
func setModifiers(modifiers:Array):
	modifier1 = modifiers[0]
	modifier2 = modifiers[1]
	
	$UI/Mod1/title.text = modifier1.title
	$UI/Mod1/desc.text = modifier1.descrption
	$UI/Mod2/title.text = modifier2.title
	$UI/Mod2/desc.text = modifier2.descrption

func _input(event: InputEvent) -> void:
	var device = event.device
	var player = globals.getPlayerId(device)
	if player == null:
		return
	if event.is_action_pressed("Left"):
		if leftChoice.has(device):
			setOutlineColor(player, false, false)
		else:
			setOutlineColor(player, true, false)
		addLeft(device)
		
		checkIfValid()
	elif event.is_action_pressed("Right"):
		if rightChoice.has(device):
			setOutlineColor(player, false, false)
		else:
			setOutlineColor(player, false, true)
		addRight(device)
		
		checkIfValid()

func addLeft(device):
	if not leftChoice.has(device):
		leftChoice.append(device)
	if rightChoice.has(device):
		rightChoice.erase(device)

func addRight(device):
	if not rightChoice.has(device):
		rightChoice.append(device)
	if leftChoice.has(device):
		leftChoice.erase(device)

func checkIfValid():
	if leftChoice.size() == globals.getNumPlayers():
		print("Modifier 1 has been chosen")
		return modifier1
	elif rightChoice.size() == globals.getNumPlayers():
		print("Modifier 2 has been chosen")
		return modifier2

func setOutlineColor(player, left:bool, right:bool):
	match player:
			0:
				Red.visible = left
				Red2.visible = right
			1:
				Blue.visible = left
				Blue2.visible = right
			2:
				Yellow.visible = left
				Yellow2.visible = right
			3:
				Green.visible = left
				Green2.visible = right
