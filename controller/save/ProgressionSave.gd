extends Resource
class_name ProgressionSave

@export var next_level: String

func has_level() -> bool:
	return next_level == null or not next_level.is_empty()
