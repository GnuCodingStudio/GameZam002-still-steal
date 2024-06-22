extends Area2D

class_name Camera

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_polygon_2d = $CollisionPolygon2D
@export var deactivation_camera_timer = 2

signal on_player_catch()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			deactivateCamera()


func _on_body_entered(body):
	if body is Player:
		on_player_catch.emit()
		
		
func activateCamera():
	animated_sprite_2d.play('on')
	collision_polygon_2d.disabled = false
	collision_polygon_2d.visible = true
	
	
func deactivateCamera():
	animated_sprite_2d.play('off')
	collision_polygon_2d.disabled = true
	collision_polygon_2d.visible = false
	await get_tree().create_timer(deactivation_camera_timer).timeout
	activateCamera()
