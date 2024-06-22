extends BasicLevel

var chest_to_collect = 1


func _on_chest_on_opened():
	chest_to_collect -= 1


func is_level_completed():
	return chest_to_collect == 0
