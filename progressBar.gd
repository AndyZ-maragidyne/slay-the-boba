extends Node

@onready var progressBar = $ProgressBar
@onready var indicator = $Label

func setProgress(value):
	progressBar.max_value = value

func updateProgress(value):
	progressBar.value = value
	updateIndicator(value)

func updateIndicator(currValue):
	indicator.text = str(int(currValue))
	var fillRatio = progressBar.ratio
	var margin = 10
	var targetX = progressBar.position.x + progressBar.size.x + margin
	var targetY = progressBar.size.y * (1.0 - fillRatio)
	targetY -= (indicator.size.y / 2.0)
	indicator.position = Vector2(targetX, progressBar.position.y + targetY)
	if indicator.position.y > 1030:
		indicator.position.y = 1030
	elif indicator.position.y < 31:
		indicator.position.y = 31
