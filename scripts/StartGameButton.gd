extends Button


func _on_pressed():
	var progression = SaveController.load_progression()
	var level_file = to_level_path(progression)
	get_tree().change_scene_to_file(level_file)


func to_level_path(progression: ProgressionSave) -> String:
	var start_level = progression.next_level
	return start_level if start_level else "res://scenes/levels/Level_01.tscn"
