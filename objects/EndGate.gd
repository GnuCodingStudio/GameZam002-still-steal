extends Node

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision: CollisionShape2D = %CollisionShape2D
@onready var unlock_door = %Unlock_Door
func _open():
	animated_sprite.play("open")
	collision.disabled = true
	await get_tree().create_timer(0.5).timeout
	unlock_door.play()
