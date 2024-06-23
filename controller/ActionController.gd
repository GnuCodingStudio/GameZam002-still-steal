extends Node
class_name ActionController


@export_range(0, 100) var max_actions: int


func activate() -> bool:
	var can_activate = max_actions > 0
	prints("Can activate", can_activate)
	
	max_actions -= 1
	return can_activate

