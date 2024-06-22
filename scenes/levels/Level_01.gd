extends Node2D

@onready var start_point = %StartPoint
@onready var finish = %FinishArea

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	var player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)


func _process(delta):
	pass


func _on_body_entered(body):
	if (body is Player):
		print('Finish')
