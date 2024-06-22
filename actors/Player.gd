extends RigidBody2D

class_name Player

@export var speed: int = 10
@export var rotation_speed: float = 10
@onready var animated_sprite_2d = $AnimatedSprite2D

var moving_direction: Vector2
var facing_direction: Vector2
var disabled: bool:
	set(value):
		moving_direction = Vector2.ZERO
		disabled = value

func _unhandled_input(event):
	if not disabled:
		moving_direction = Input.get_vector("left", "right", "up", "down")
	
	if moving_direction != Vector2.ZERO:
		facing_direction = moving_direction


func _physics_process(delta):
	move_and_collide(moving_direction.normalized() * speed)
	_adjust_orientation()


func _adjust_orientation():
	if moving_direction != Vector2.ZERO:
		_ajust_moving_orientation()
	else:
		_ajust_facing_orientation()

func _ajust_moving_orientation():
	if moving_direction.x < 0:
		animated_sprite_2d.play("run_to_the_left")
	elif moving_direction.x > 0:
		animated_sprite_2d.play("run_to_the_right")
	elif moving_direction.y < 0:
		animated_sprite_2d.play("run_to_the_top")
	elif moving_direction.y > 0:
		animated_sprite_2d.play("run_to_the_bottom")
		
func _ajust_facing_orientation():
	if facing_direction.x < 0:
		animated_sprite_2d.play("facing_left")
	elif facing_direction.x > 0:
		animated_sprite_2d.play("facing_right")
	elif facing_direction.y < 0:
		animated_sprite_2d.play("facing_top")
	elif facing_direction.y > 0:
		animated_sprite_2d.play("facing_bottom")
	
