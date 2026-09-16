extends Node

class_name Menu

var slots = []

func _init(numSlots: int = 3):
	for i in range(numSlots):
		slots.append([])

func addSlot():
	slots.append([])

func addItem(item, index):
	slots[index].append(item)
