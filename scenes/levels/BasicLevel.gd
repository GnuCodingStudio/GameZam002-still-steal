extends Node2D
class_name BasicLevel

@export var start_point: Node2D
@export var finish_area: Area2D
@export var next_level: PackedScene

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	var player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)
	
	finish_area.body_entered.connect(_finish_entered)


func _finish_entered(body):
	if is_level_completed() and body is Player:
		print("Level completed")
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)


func is_level_completed() -> bool:
	return true
