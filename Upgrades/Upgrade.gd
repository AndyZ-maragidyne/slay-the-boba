extends Node
class_name Upgrade

@onready var borderRed = $BorderRed
@onready var borderBlue = $BorderBlue
@onready var borderYellow = $BorderYellow
@onready var borderGreen = $BorderGreen

@export var clickable: bool = false

func _ready() -> void:
	pass

func onBuy():
	pass

func onClick(playerId):
	pass

func clicked(playerId):
	pass

func setSelected(selected:bool, playerId):
	match playerId:
		0:
			borderRed.visible = selected
		1:
			borderBlue.visible = selected
		2:
			borderYellow.visible = selected
		3:
			borderGreen.visible = selected
	self.z_index = 10 if selected else 0
	pass
