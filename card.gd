extends Node2D

class_name Card

@export var cost: int
@export var cardName: String
@export var item: PackedScene
@export var itemData: ItemData

@onready var borderRed: ReferenceRect = $BorderRed
@onready var borderBlue: ReferenceRect = $BorderBlue
@onready var borderYellow: ReferenceRect = $BorderYellow
@onready var borderGreen: ReferenceRect = $BorderGreen

func _ready() -> void:
	borderRed.visible = false
	borderBlue.visible = false
	borderYellow.visible = false
	borderGreen.visible = false


func set_selected(is_selected: bool, deviceId) -> void:
	match deviceId:
		0:
			borderRed.visible = is_selected
		1:
			borderBlue.visible = is_selected
		2:
			borderYellow.visible = is_selected
		3:
			borderGreen.visible = is_selected
	z_index = 10 if is_selected else 0
