extends Node2D
class_name BasicLevel

@export var start_point: Node2D
@export var finish_area: Area2D

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	var player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)
	
	finish_area.body_entered.connect(_finish_entered)


func _finish_entered(body):
	if is_level_completed() and body is Player:
		print("Level completed")


func is_level_completed() -> bool:
	return true
