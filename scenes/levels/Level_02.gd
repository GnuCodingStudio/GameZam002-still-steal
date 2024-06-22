extends Node2D

var chest_to_collect = 1


func _on_chest_on_opened():
	chest_to_collect -= 1


func _on_finish_area_entered(body):
	if chest_to_collect <= 0:
		print("Finished")
