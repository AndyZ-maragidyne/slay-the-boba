extends Node2D

@export var layers = 1

var colors: Array[Color] = []

var index = 0
func setColor(c:Color):
	colors.append(c)
	if colors.size() >= 2:
		c = mix_colors(colors)
	$Cup/Color.color = c
	$Cup/Color.visible = true
	if index >= 1 and layers >= 2:
		$Cup/Color2.color = c
		$Cup/Color2.visible = true
	if index >= 2 and layers >= 3:
		$Cup/Color3.color = c
		$Cup/Color3.visible = true
	index +=1
	

func mix_colors(colors: Array[Color]) -> Color:
	if colors.is_empty():
		return Color.WHITE
		
	var r = 0.0
	var g = 0.0
	var b = 0.0
	var a = 0.0
	
	# Add up all the color channels
	for c in colors:
		r += c.r
		g += c.g
		b += c.b
		a += c.a
		
	# Divide by the total number of colors to get the average
	var count = float(colors.size())
	return Color(r / count, g / count, b / count, a / count)
