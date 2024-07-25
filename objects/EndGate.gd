extends Node

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision_gate: CollisionShape2D = %CollisionGate
@onready var unlock_door = %Unlock_Door
@onready var collision_finish: CollisionShape2D = %CollisionShape2D

func _ready():
	collision_finish.disabled = false

func open():
	await get_tree().create_timer(0.8).timeout
	animated_sprite.play("open")
	collision_gate.disabled = true
	unlock_door.play()
