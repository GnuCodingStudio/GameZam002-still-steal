extends RigidBody2D

class_name Player

@export var speed: int = 10
@export var rotation_speed: float = 10

var direction: Vector2
var facing_direction: Vector2

func _unhandled_input(event):
	direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		facing_direction = direction


func _physics_process(delta):
	move_and_collide(direction.normalized() * speed)
	_adjust_orientation(facing_direction, delta)


func _adjust_orientation(orientation: Vector2, delta: float):
	var angle_diff = angle_difference(rotation, orientation.angle())
	rotate(angle_diff * rotation_speed * delta)
