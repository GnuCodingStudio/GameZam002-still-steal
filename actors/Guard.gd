@tool
extends RigidBody2D

class_name Guard

@export_range(0.1, 20.0) var speed: float = 5
@export var rotation_speed: float = 10
@export var path_follow: PathFollow2D
@export var action_controller: ActionController
@export var facing_direction: Direction = Direction.BOTTOM
@export var sharedFollowPath: bool = false

@onready var detector_area = %DetectorArea
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var visible_area = %VisibleArea

signal stun_guard()
signal on_player_catch()

var moving_direction: Vector2
var last_position: Vector2
var state: GuardState = GuardState.MOVING

enum GuardState { STUN, MOVING }
enum Direction { TOP, RIGHT, BOTTOM, LEFT }

func _ready():
	#Static guard has not path follow
	if not Engine.is_editor_hint() and path_follow != null:
		if(!sharedFollowPath):
			path_follow.progress_ratio = randf()
		else:
			path_follow.progress_ratio = 0
	_ajust_facing_orientation(facing_direction)

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

	if path_follow != null and state == GuardState.MOVING:
		path_follow.progress += (60 * speed * delta)
		move_and_collide(path_follow.global_position - global_position)

		if last_position != null:
			moving_direction = global_position - last_position
			if moving_direction.length() > 0:
				facing_direction = _vector_to_direction(moving_direction)
			_adjust_orientation()
		last_position = global_position


func _adjust_orientation():
	if moving_direction != Vector2.ZERO:
		_ajust_moving_orientation()
	else:
		_ajust_facing_orientation(facing_direction)


func _ajust_moving_orientation():
	var x_direction = moving_direction.x
	var y_direction = moving_direction.y
	var isHorizontalyMoved = abs(x_direction) > abs(y_direction)
	if isHorizontalyMoved:
		if moving_direction.x < 0:
			animated_sprite_2d.play("run_to_the_left")
			detector_area.rotation_degrees = 90
		elif moving_direction.x > 0:
			animated_sprite_2d.play("run_to_the_right")
			detector_area.rotation_degrees = -90
	else:
		if moving_direction.y < 0:
			animated_sprite_2d.play("run_to_the_top")
			detector_area.rotation_degrees = 180
		elif moving_direction.y > 0:
			animated_sprite_2d.play("run_to_the_bottom")
			detector_area.rotation_degrees = 0


func _ajust_facing_orientation(direction: Direction):
	match direction:
		Direction.TOP:
			animated_sprite_2d.play("facing_top")
			detector_area.rotation_degrees = 180
		Direction.RIGHT:
			animated_sprite_2d.play("facing_right")
			detector_area.rotation_degrees = -90
		Direction.BOTTOM:
			animated_sprite_2d.play("facing_bottom")
			detector_area.rotation_degrees = 0
		Direction.LEFT:
			animated_sprite_2d.play("facing_left")
			detector_area.rotation_degrees = 90


func _vector_to_direction(vector: Vector2) -> Direction:
	if vector.x < 0:
		return Direction.LEFT
	elif vector.x > 0:
		return Direction.RIGHT
	elif vector.y < 0:
		return Direction.TOP
	elif vector.y > 0:
		return Direction.BOTTOM
	else:
		return Direction.BOTTOM

func _on_actionnable_input_event(viewport, event, shape_idx):
	CursorController.use_scope()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			stun()

func stun():
	if state == GuardState.STUN:
		return

	if action_controller == null or action_controller.activate():
		state = GuardState.STUN
		animated_sprite_2d.play("stun")
		self.modulate = Color(0.5,0.5,0.5)
		visible_area.visible = false


func _on_player_detected():
	if state != GuardState.STUN:
		print("Spotted")
		on_player_catch.emit()


## Check if guard can see the body or if there something between them
func _can_see(body) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, body.global_position)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.hit_from_inside = true
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	return result.has("collider") and result["collider"] == body


func _on_area_mouse_exited():
	CursorController.reset_default()
