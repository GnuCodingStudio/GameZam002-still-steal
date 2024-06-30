extends Node2D

class_name Camera

@onready var detection_area = %DetectionArea
@onready var animated_sprite = %AnimatedSprite
@onready var detection_shape = %DetectionShape
@onready var audio_off = %AudioOff
@onready var audio_on = %AudioOn

@export var deactivation_camera_timer = 2
@export var action_controller: ActionController

@export_group("Rotation", "rotation_")
@export var rotation_enabled: bool = false
@export var rotation_start_angle: float = 0.0
@export var rotation_end_angle: float = 90.0
@export var rotation_seconds: float = 3.0

var animPlayer = AnimationPlayer

signal on_player_catch()

func _ready():
	if rotation_enabled:
		animPlayer = _create_animation_player()
		animPlayer.play("global/rotate")


func _create_animation_player() -> AnimationPlayer:
	var animPlayer = AnimationPlayer.new()
	add_child(animPlayer)

	var animLibrary = AnimationLibrary.new()
	animPlayer.add_animation_library("global", animLibrary)

	var roty = Animation.new()
	animLibrary.add_animation("rotate", roty)

	var track_index = roty.add_track(Animation.TYPE_VALUE)
	roty.track_set_path(track_index, ".:rotation_degrees")
	roty.track_insert_key(track_index, 0.0, rotation_start_angle)
	roty.track_insert_key(track_index, rotation_seconds / 2.0, rotation_end_angle)
	roty.length = rotation_seconds / 2.0
	roty.loop_mode = Animation.LOOP_PINGPONG
	
	return animPlayer

func _physics_process(delta):
	pass
	

func _on_body_entered(body):
	if body is Player and _can_see(body):
		on_player_catch.emit()

func activateCamera():
	animated_sprite.play("on")
	audio_on.play()
	detection_shape.disabled = false
	detection_area.visible = true


func deactivateCamera():
	if action_controller == null or action_controller.activate():
		animated_sprite.play("off")
		audio_off.play()
		detection_shape.disabled = true
		detection_area.visible = false
		await get_tree().create_timer(deactivation_camera_timer).timeout
		activateCamera()


func _on_actionnable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			deactivateCamera()


## Check if guard can see the body or if there something between them
func _can_see(body) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, body.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	return result.collider == body
