extends CanvasLayer

const first_level_file = "res://scenes/levels/Level_01.tscn"


@onready var continue_button = %ContinueButton


func _ready():
	var progression = SaveController.load_progression()
	if progression.has_level():
		continue_button.visible = true
	else:
		continue_button.visible = false


func _on_continue_button_pressed():
	var progression = SaveController.load_progression()
	var level_file = to_level_path(progression)
	_load_level(level_file)


func _on_restart_button_pressed():
	_load_level(first_level_file)


func to_level_path(progression: ProgressionSave) -> String:
	var start_level = progression.next_level
	return start_level if start_level else first_level_file


func _load_level(file: String):
	get_tree().change_scene_to_file(file)
