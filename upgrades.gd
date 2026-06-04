extends StoreShelf

func replaceWith(hi, child):
	var index = 0
	for i in itemPool:
		if i.Item == child:
			itemPool[index] = hi
			return
		index += 1
