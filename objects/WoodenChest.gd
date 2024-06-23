extends Node2D

@onready var accessible_area: Area2D = %AccessibleArea
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var coin = %Coin

signal on_opened()

var is_closed = true


func _unhandled_key_input(event):
	if event.is_action_pressed("activate"):
		_try_activate()


func _try_activate():
	if not is_closed:
		return
	
	var overlappingBodies = accessible_area.get_overlapping_bodies()
	if overlappingBodies.any(func (elem): return elem is Player):
		is_closed = false
		coin.play()
		animated_sprite.play("opened")
		on_opened.emit()
