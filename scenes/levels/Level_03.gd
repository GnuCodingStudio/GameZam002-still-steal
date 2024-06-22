extends Node2D

@onready var start_point = %StartPoint
@onready var finish = %FinishArea
@onready var camera_position = $CameraPosition
@onready var camera: Camera = %Camera

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	var player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)
	camera.activateCamera()


func _on_body_entered(body):
	if (body is Player):
		print("Finish")
