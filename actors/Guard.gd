extends RigidBody2D

class_name Guard

@export var speed: int = 5
@export var rotation_speed: float = 10
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var path_follow: PathFollow2D
@export var action_controller: ActionController

signal stun_guard()

var moving_direction: Vector2
var facing_direction: Vector2
var last_position: Vector2
var state: GuardState = GuardState.MOVING

enum GuardState { STUN, MOVING }

func _ready():
	#Static guard has not path follow
	if(path_follow != null):
		path_follow.progress_ratio = randf()


func _physics_process(delta):
	if path_follow != null and state == GuardState.MOVING:
		path_follow.progress += (60 * speed * delta)
		move_and_collide(path_follow.global_position - global_position)
		
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


func _on_actionnable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			stun()

func stun():
	if action_controller == null or action_controller.activate():
		state = GuardState.STUN
		animated_sprite_2d.play("stun")
		self.modulate = Color(0.5,0.5,0.5)
	
	
