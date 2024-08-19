extends Node2D

class_name Camera

@onready var detector = %Detector
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
var _scanning: bool = true

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


func activateCamera():
	if not _scanning:
		_scanning = true
		animated_sprite.play("on")
		audio_on.play()
		detection_shape.disabled = false
		detector.visible = true


func deactivateCamera():
	if _scanning:
		if action_controller == null or action_controller.activate():
			_scanning = false
			animated_sprite.play("off")
			audio_off.play()
			detection_shape.disabled = true
			detector.visible = false
			await get_tree().create_timer(deactivation_camera_timer).timeout
			activateCamera()


func _on_actionnable_input_event(viewport, event, shape_idx):
	CursorController.use_wrench()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			deactivateCamera()


func _on_area_mouse_exited():
	CursorController.reset_default()


func _on_player_detected():
	on_player_catch.emit()
