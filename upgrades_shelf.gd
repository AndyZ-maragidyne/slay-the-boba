extends Node2D

@export var selectableUpgrades:Array = []
var displayUpgrades:Array = []
var displayPrices:Array = []
var upgradesPerRow = 5

func _ready() -> void:
	var upgradeL = UpgradeListing.new(preload("res://Upgrades/Boba Machine.tscn"))
	var upgradeB = UpgradeListing.new(preload("res://Upgrades/broom.tscn"))
	var upgradeR = UpgradeListing.new(preload("res://Upgrades/Refreshed.tscn"))
	#upgradeL.upgrade = preload("res://Upgrades/Boba Machine.tscn")
	selectableUpgrades.append(upgradeL)
	selectableUpgrades.append(upgradeB)
	selectableUpgrades.append(upgradeR)
	displayItems()
	
func addNewUpgrade(upgrade):
	selectableUpgrades.append(upgrade)

func setSelected(playerId, coordx, coordy, selected:bool):
	#might not work
	var selectedUpgrade = displayUpgrades[upgradesPerRow*coordx + coordy]
	selectedUpgrade.setSelected(selected, playerId)
	selectedUpgrade.borderRed.border_width = 6.0
	selectedUpgrade.borderBlue.border_width = 6.0
	selectedUpgrade.borderYellow.border_width = 6.0
	selectedUpgrade.borderGreen.border_width = 6.0

var spacebtwnrow = 50
func displayItems():
	for c in displayUpgrades:
		c.queue_free()
	for p in displayPrices:
		p.queue_free()
	displayUpgrades.clear()
	displayPrices.clear()
	
	var index = 0
	var rowNum = 0
	var fiveperrow = [-400, -200, 0, 200, 400]
	while index < selectableUpgrades.size():
		for shelf in upgradesPerRow:
			if index >= selectableUpgrades.size():
				return
			#iterate 5 times, then increase rowNum
			#instantiate card
			var item = selectableUpgrades[index].upgradeReal
			add_child(item)
			displayUpgrades.append(item)
			item.position = Vector2(fiveperrow[index%5], spacebtwnrow*rowNum)
			
			
			#Then make the price
			var price = Label.new()
			price.text = "$" + str(selectableUpgrades[index].price)
			price.position = Vector2(item.position) + Vector2(-20, 100)
			price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			price.add_theme_font_size_override("font_size", 30)
			add_child(price)
			
			index += 1
		rowNum += 1
