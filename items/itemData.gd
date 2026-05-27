extends Resource
class_name ItemData

enum Category {CUP, LIQUID, TOPPING}

@export var itemName: String
@export var category: Category

@export var color: Color = Color.WHITE
