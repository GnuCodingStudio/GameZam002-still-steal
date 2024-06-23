extends CanvasLayer
class_name ActionController


@export_range(0, 100) var max_actions: int


@onready var remaining_actions = %RemainingActions


func _ready():
	remaining_actions.text = str(max_actions)

func activate() -> bool:
	var can_activate = max_actions > 0
	prints("Can activate", can_activate)
	
	if max_actions >= 0:
		max_actions -= 1
		remaining_actions.text = str(max(max_actions, 0))
	
	return can_activate

