extends Node2D

class_name Card

@export var data: CardData
var player
@export var cost:int
@export var cardName:String
@export var description:String
@export var item:PackedScene
@export var limitedUses:bool = false
@export var maxUses:int = -1
@export var spawnItem:bool = true
@export var itemData:Resource

@onready var uses:int

@onready var borderRed: ReferenceRect = $BorderRed
@onready var borderBlue: ReferenceRect = $BorderBlue
@onready var borderYellow: ReferenceRect = $BorderYellow
@onready var borderGreen: ReferenceRect = $BorderGreen

static func create(blueprint: CardData) -> Card:
	var scene = preload("res://Cards/Card.tscn")
	var instance = scene.instantiate()
	
	instance.data = blueprint
	instance.loadInfo()
	return instance

func _ready() -> void:
	borderRed.visible = false
	borderBlue.visible = false
	borderYellow.visible = false
	borderGreen.visible = false
	
	setupUI()

func loadInfo():
	cost = data.cost
	cardName = data.cardName
	description = data.description
	item = data.item
	limitedUses = data.limitedUses
	maxUses = data.maxUses
	spawnItem = data.spawnItem
	itemData = data.itemData
	
func setupUI() -> void:
	$Cost.text = str(cost)
	$Name.text = cardName
	if itemData:
		$Desc1.text = str(itemData.pointValue) + " rep\n" + str(itemData.coinValue) + " coins"
	else:
		$Desc1.text = ""
	$Desc2.text = description
	if limitedUses:
		$UsesLeft.text = str(uses) + " use"
	else:
		$UsesLeft.text = ""


func set_selected(is_selected: bool, playerId) -> void:
	match playerId:
		0:
			borderRed.visible = is_selected
		1:
			borderBlue.visible = is_selected
		2:
			borderYellow.visible = is_selected
		3:
			borderGreen.visible = is_selected
	z_index = 10 if is_selected else 0

#Whenever the card gets played
func onPlay():
	data.onAbility(self, player)
	if limitedUses:
		uses -= 1
		$UsesLeft.text = str(uses) + " use"
	pass

func modifyCost(newcost):
	cost += newcost
	$Cost.text = str(cost)

func destroyCard() -> void:
	queue_free()

func setPlayer(person):
	player = person
