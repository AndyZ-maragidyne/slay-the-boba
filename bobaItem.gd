extends Node2D

var iterations:int = 0

@export var bobaScene = preload("res://bobaSingular.tscn")

func _ready() -> void:
	spawnBoba()

func spawnBoba():
	var boba = bobaScene.instantiate()
	add_child(boba)
	boba.global_position.x += randf_range(-10, 10)
	iterations += 1
	if iterations < 10:
		$Timer.start()

func _on_timer_timeout() -> void:
	spawnBoba()
	pass # Replace with function body.
