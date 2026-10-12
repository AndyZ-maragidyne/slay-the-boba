extends Upgrade

@onready var refreshedModifier = preload("res://Modifier/Scripts/Refreshed.gd")
@onready var refreshedReal = refreshedModifier.new()

func clicked(playerId):
	globals.modifiers.append(refreshedReal)
