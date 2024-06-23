extends Node2D

class_name Camera

@onready var detection_area = %DetectionArea
@onready var animated_sprite = %AnimatedSprite
@onready var detection_shape = %DetectionShape
@onready var audio_down = %AudioDown
@onready var audio_up = %AudioUp
@export var deactivation_camera_timer = 2
@export var action_controller: ActionController

signal on_player_catch()


func _on_body_entered(body):
	if body is Player:
		on_player_catch.emit()


func activateCamera():
	animated_sprite.play("on")
	audio_up.play()
	detection_shape.disabled = false
	detection_area.visible = true


func deactivateCamera():
	if action_controller == null or action_controller.activate():
		animated_sprite.play("off")
		audio_down.play()
		detection_shape.disabled = true
		detection_area.visible = false
		await get_tree().create_timer(deactivation_camera_timer).timeout
		activateCamera()


func _on_actionnable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			deactivateCamera()
