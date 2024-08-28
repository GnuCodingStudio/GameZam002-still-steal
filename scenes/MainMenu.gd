extends CanvasLayer

const first_level_file = "res://scenes/levels/Level_01.tscn"


@onready var continue_button = %ContinueButton
@onready var game_console = %GameConsole


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


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits/Credits.tscn")


func _debug_invisible(target: String):
	match(target):
		"camera", "cameras":
			DebugController.detectable_by_camera = false
			game_console.log_info("Cameras disabled")
		"guard", "guards":
			DebugController.detectable_by_guard = false
			game_console.log_info("Guards disabled")
		"all":
			DebugController.detectable_by_camera = false
			DebugController.detectable_by_guard = false
			game_console.log_info("Cameras and Guards disabled")
		"none", "zero":
			DebugController.detectable_by_camera = true
			DebugController.detectable_by_guard = true
			game_console.log_info("Cameras and Guards enabled")
		_:
			game_console.log_error("Invalid parameter")


func _start_level(number: int):
	var level_path = "res://scenes/levels/Level_%02d.tscn" % number
	if ResourceLoader.exists(level_path):
		_load_level(level_path)
	else:
		game_console.log_error("This level doesn't exist")
