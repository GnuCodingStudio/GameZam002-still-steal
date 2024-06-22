extends RigidBody2D

class_name Guard

@export var speed: int = 5
@export var rotation_speed: float = 10
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var path_follow: PathFollow2D

var moving_direction: Vector2
var facing_direction: Vector2
var last_position: Vector2

func _ready():
	path_follow.progress_ratio = randf()
	
func _unhandled_input(event):
	if moving_direction != Vector2.ZERO:
		facing_direction = moving_direction


func _physics_process(delta):
	path_follow.set_progress(path_follow.progress + 60 * speed * delta)
	if last_position != null:
		moving_direction = global_position - last_position
		_adjust_orientation()
	last_position = global_position


func _adjust_orientation():
	if moving_direction != Vector2.ZERO:
		_ajust_moving_orientation()
	else:
		_ajust_facing_orientation()

func _ajust_moving_orientation():
	var x_direction = moving_direction.x
	var y_direction = moving_direction.y
	var isHorizontalyMoved = abs(x_direction) > abs(y_direction)
	if isHorizontalyMoved:
		if moving_direction.x < 0:
			animated_sprite_2d.play("run_to_the_left")
		elif moving_direction.x > 0:
			animated_sprite_2d.play("run_to_the_right")
	else:
		if moving_direction.y < 0:
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
