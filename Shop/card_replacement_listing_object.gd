extends Node2D

@export var listing = CardReplacementListing.new()
@onready var card = $Card

func setSelected(playerId, selected):
	card.set_selected(selected, playerId)
