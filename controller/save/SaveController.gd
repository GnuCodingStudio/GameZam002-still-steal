extends Node


var save_file_path = "user://save/"

var progression_file_name = save_file_path + "progression.json"


func _ready():
	DirAccess.make_dir_absolute(save_file_path)


func load_progression() -> ProgressionSave:
	if FileAccess.file_exists(progression_file_name):
		var file = FileAccess.open(progression_file_name, FileAccess.READ)
		var data = _parse(file.get_as_text())
		file.close()
		return data
	else:
		return ProgressionSave.new()


func update_progression(scene: Node):
	var progression = ProgressionSave.new()
	progression.next_level = scene.scene_file_path
	
	var content = _serialize(progression)
	var file = FileAccess.open(progression_file_name, FileAccess.WRITE)
	file.store_string(content)
	file.close()


func _serialize(progression: ProgressionSave) -> String:
	return JSON.stringify({
		"next_level": progression.next_level
	})


func _parse(json: String) -> ProgressionSave:
	var dict = JSON.parse_string(json)
	var progression = ProgressionSave.new()
	progression.next_level = dict["next_level"]
	return progression
