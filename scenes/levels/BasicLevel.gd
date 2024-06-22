extends Node2D
class_name BasicLevel

@export var start_point: Node2D
@export var finish_area: Area2D
@export var next_level: PackedScene

var player: Player
var _chests_to_open = 0

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)
	
	finish_area.body_entered.connect(_finish_entered)
	
	var chests = get_tree().get_nodes_in_group("chests")
	_chests_to_open = chests.size()
	for chest in chests:
		chest.on_opened.connect(_on_chest_opened)



func _finish_entered(body):
	if is_level_completed() and body is Player:
		player.modulate.a = .5
		player.disabled = true
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_packed(next_level)


func _on_chest_opened():
	_chests_to_open -= 1


func is_level_completed() -> bool:
	return _chests_to_open == 0
