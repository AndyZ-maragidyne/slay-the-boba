extends Resource
class_name ItemData

enum Category {CUP, LIQUID, TOPPING}
enum Size {NONE, SMALL, MEDIUM, LARGE}
enum LiquidType {NONE, MILK, TEA, MISC}

@export var itemName: String
@export var category: Category
@export var pointValue: int
@export var coinValue: int

@export var size: Size
@export var liquidType: LiquidType
@export var color: Color = Color.WHITE
