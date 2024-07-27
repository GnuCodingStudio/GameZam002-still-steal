extends Node
class_name EndGate

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision_gate: CollisionShape2D = %CollisionGate
@onready var finish_shape: CollisionShape2D = %FinishShape
@onready var unlock_door = %Unlock_Door

signal finish_body_entered(body)


func _ready():
	finish_shape.disabled = true


func open():
	await get_tree().create_timer(0.8).timeout
	animated_sprite.play("open")
	finish_shape.disabled = false
	collision_gate.disabled = true
	unlock_door.play()


func _on_finish_body_entered(body):
	finish_body_entered.emit(body)
