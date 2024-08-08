extends BasicLevel

func _ready():
	super._ready()
	var guards = get_tree().get_nodes_in_group("guards")
	for guard in guards:
		guard.visible = false
		guard.detection_area.visible = false
		guard.detection_area.monitoring = false

