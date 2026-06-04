extends Node2D

@onready var borderRed: ReferenceRect = $Stuff/BorderRed
@onready var borderBlue: ReferenceRect = $Stuff/BorderBlue
@onready var borderYellow: ReferenceRect = $Stuff/BorderYellow
@onready var borderGreen: ReferenceRect = $Stuff/BorderGreen
@onready var score: Label = $Stuff/Score
var itemDatas: Array[ItemData] = []
var placedItems:Array = []

func _ready() -> void:
	borderRed.visible = false
	borderBlue.visible = false
	borderYellow.visible = false
	borderGreen.visible = false
	score.text = str(scoreDrink())
	

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

func apply_card(card:Card) -> void:
	itemDatas.append(card.itemData)
	if card.item != null:
		var newItem = card.item.instantiate()
		add_child(newItem)
		placedItems.append(newItem)
		newItem.global_position = $Stuff/SpawnPoint.global_position
	else:
		placedItems.append(null)
		if card.itemData.category == ItemData.Category.LIQUID:
			var index = 0
			for i in itemDatas:
				if i.category == ItemData.Category.CUP:
					placedItems[index].setColor(card.itemData.color)
					score.text = str(scoreDrink())
					return
				index += 1
			pass
	score.text = str(scoreDrink())

func scoreDrink():
	#find where the first cup is
	#gather stuff after the first cup
	var firstIndex = 0
	var totalPoints = 0
	var numLiquid = 0
	var numToppings = 0
	var maxThings = 0
	var cup = false
	for i in itemDatas:
		#first, find the first cup. Lose a point for each ingredient thats not cup
		if !cup:
			print("cup?")
			if i.category == ItemData.Category.CUP:
					totalPoints += i.pointValue
					cup = true
					print("cup found")
					if i.size == ItemData.Size.SMALL:
						maxThings = 1
					elif i.size == ItemData.Size.MEDIUM:
						maxThings = 2
					elif i.size == ItemData.Size.LARGE:
						maxThings = 3
			else:
				print("no cup first")
				totalPoints -= 1
				firstIndex+= 1
		#Afterwards, iterate and score points or lose points. small can only hold 1 topping/liquid, medium 2, large 3
		#Any after the threshold loses points
		else:
			if i.category == ItemData.Category.CUP:
				totalPoints -= 2
			elif i.category == ItemData.Category.LIQUID:
				print("Max things: " + str(maxThings))
				if numLiquid < maxThings:
					numLiquid += 1
					totalPoints += i.pointValue
				else:
					totalPoints -= 1
			elif i.category == ItemData.Category.TOPPING:
				print("topping found")
				if numToppings < maxThings:
					numToppings += 1
					totalPoints += i.pointValue
				else:
					totalPoints -= 1
	if numLiquid < maxThings:
		if maxThings == 2:
			
			var pointsLost = maxThings - numLiquid
			print("Medium Cup not filled all the way. Losing " + str(pointsLost) + " points")
			totalPoints -= pointsLost
		elif maxThings == 3:
			
			var pointsLost = (maxThings - numLiquid) * 2
			print("Large Cup not filled all the way. Losing " + str(pointsLost) + " points")
			totalPoints -= pointsLost
	if numLiquid == 0:
		totalPoints -= 5
	if !cup:
		totalPoints -= 5
	#nothing also loses a lot
	return totalPoints
	pass

func scoreCoins():
	var total = 0
	for i in itemDatas:
		total += i.coinValue
	return total
