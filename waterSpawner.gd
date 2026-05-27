extends Marker2D

@export var dropletScene: PackedScene
@onready var container = get_parent()

var pouring:bool = false
func _ready() -> void:
	pour()

func pour():
	$Timer2.start()
	pouring = true
	
func _process(delta: float) -> void:
	#if pouring:
		#spawnLiquid()
		#spawnLiquid()
		#spawnLiquid()
	pass
	
func spawnLiquid():
	var drop = dropletScene.instantiate()
	drop.global_position = global_position
	
	drop.global_position.x += randf_range(-0.001, 0.001)
	
	container.add_child(drop)
		
func _on_timer_timeout():
	if pouring:
		spawnLiquid()
		spawnLiquid()
		spawnLiquid()


func _on_timer_2_timeout() -> void:
	pouring = false
	pass # Replace with function body.
