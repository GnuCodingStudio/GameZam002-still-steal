extends Node


var save_file_path = "user://save/"

var progression_file_name = save_file_path + "Progression.tres"
var progression: ProgressionSave = ProgressionSave.new()


func _ready():
	DirAccess.make_dir_absolute(save_file_path)


func load_progression() -> ProgressionSave:
	var data = ResourceLoader.load(progression_file_name)
	if data is ProgressionSave:
		progression = data.duplicate(true)
	return progression


func update_progression(scene: Node):
	progression.next_level = scene.scene_file_path
	ResourceSaver.save(progression, progression_file_name, 0)
