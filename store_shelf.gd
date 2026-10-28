extends Node2D
class_name StoreShelf

var itemPool: Array[Array]
var shelf1: Array
var shelf2: Array
var shelf3: Array
var shelf4: Array
var shelf5: Array
var displayCards:Array = []
var displayPrices:Array = []
func _ready() -> void:
	setup(globals.unlockedCardPool)
	displayItems()
	pass

func setup(item_pool):
	itemPool = item_pool
	shelf1 = itemPool[0]
	shelf2 = itemPool[1]
	shelf3 = itemPool[2]
	shelf4 = itemPool[3]

func setSelected(playerId, coordx, coordy, selected:bool):
	#the item to get from the array is like (4 * x) + y
	var selectedCard = displayCards[(4*coordx + coordy)]
	#var selectedCard = itemPool[coordx][coordy] #set color to the player color
	selectedCard.set_selected(selected, playerId)
	selectedCard.borderRed.border_width = 6.0
	selectedCard.borderBlue.border_width = 6.0
	selectedCard.borderYellow.border_width = 6.0
	selectedCard.borderGreen.border_width = 6.0

func getCard(coordx, coordy):
	return displayCards[(4*coordx + coordy)]

func shuffle():
	itemPool.shuffle()

var fourperrow = [-300, -100, 100, 300]
var fiveperrow = [-400, -200, 0, 200, 400]
var spacebtwnrow = 250

func displayItems():
	for c in displayCards:
		c.queue_free()
	for p in displayPrices:
		p.queue_free()
	displayCards.clear()
	displayPrices.clear()
	var rowNum = 0
	for shelf in itemPool:
		var index = 0
		for card in shelf:
			var item = Card.create(card.card)
			add_child(item)
			displayCards.append(item)
			item.position = Vector2(fourperrow[index], spacebtwnrow*rowNum)
			var price = Label.new()
			price.text = "$" + str(card.price)
			price.position = Vector2(item.position) + Vector2(-20, 100)
			price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			price.add_theme_font_size_override("font_size", 30)
			displayPrices.append(price)
			add_child(price)
			
			index += 1
		rowNum += 1
