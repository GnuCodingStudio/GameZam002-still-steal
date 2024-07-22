extends Node

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision: CollisionShape2D = %CollisionShape2D

func _open():
	animated_sprite.play("open")
	collision.disabled = true
