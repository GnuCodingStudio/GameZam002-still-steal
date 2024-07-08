extends CanvasLayer

const first_level_file = "res://scenes/levels/Level_01.tscn"


@onready var start_button = %StartButton
@onready var restart_button = %RestartButton


func _ready():
	var progression = SaveController.load_progression()
	if progression.has_level():
		start_button.text = " Continuer "
		restart_button.visible = true
	else:
		restart_button.visible = false


func _on_start_button_pressed():
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
