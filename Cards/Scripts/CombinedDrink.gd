extends CardData
class_name CombinedDrink

@export var ingredients: Array[CardData]

static func create(blueprint: Array[CardData]) -> CardData:
	var data = CombinedDrink.new()
	data.ingredients = blueprint
	data.createCard()
	return data

func addIngredient(ingredient:CardData):
	ingredients.append(ingredient)

func createCard():
	var milk = false
	var tea = false
	var fruit = false
	var milkCard
	var teaCard
	var fruitCard
	
	var index = 0
	for i in ingredients:
		if i.itemData.liquidType == ItemData.LiquidType.MILK:
			milk = true
			milkCard = ingredients[index]
		elif i.itemData.liquidType == ItemData.LiquidType.TEA:
			tea = true
			teaCard = ingredients[index]
		elif i.itemData.liquidType == ItemData.LiquidType.FRUIT:
			fruit = true
			fruitCard = ingredients[index]
		index += 1

	var data = ItemData.new()
	
	if milk and tea:
		cardName = teaCard.itemData.itemName + " Milk Tea"
		data.liquidType = ItemData.LiquidType.MILK_TEA
	elif tea and fruit:
		cardName = fruitCard.itemData.itemName + " " + teaCard.itemData.itemName + " Tea"
		data.liquidType = ItemData.LiquidType.FRUIT_TEA
	elif fruit and milk:
		cardName = fruitCard.itemData.itemName + " Slush"
		data.liquidType = ItemData.LiquidType.SLUSH
	
	
	#If you want to change the amount of bonus points for crafting, change this. Right now, you dont get anything for crafting
	var rep = 0
	var coins = 0
	for i in ingredients:
		rep += i.itemData.pointValue
		coins += i.temData.coinValue
	data.pointValue = rep
	data.coinValue = coins
	data.category = ItemData.Category.LIQUID
	
	#Make new itemData
	#Add it to the variable
