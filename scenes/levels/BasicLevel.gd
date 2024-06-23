extends Node2D
class_name BasicLevel

@export var start_point: Node2D
@export var finish_area: Area2D
@export var next_level: PackedScene
@export var intro: AudioStream

var player: Player
var _chests_to_open = 0

const ohoh = preload("res://assets/audio/OhOh.ogg")

func _ready():
	var playerScene = preload("res://actors/Player.tscn")
	player = playerScene.instantiate()
	player.position = start_point.position
	add_child(player)

	finish_area.body_entered.connect(_finish_entered)

	_init_chests()
	_init_cameras()
	_init_guards()
	_init_level()


func _init_level():
	if intro != null and IntrosController.can_play(intro.resource_path):
		IntrosController.on_intro_played(intro.resource_path)
		player.disabled = true
		await _play_intro()
		player.disabled = false


func _play_intro() -> Signal:
	if intro != null:
		var audioPlayer = AudioStreamPlayer.new()
		add_child(audioPlayer)
		audioPlayer.stream = intro
		audioPlayer.volume_db = 0
		audioPlayer.play()
		return audioPlayer.finished
	return get_tree().create_timer(0).timeout


func _init_chests():
	var chests = get_tree().get_nodes_in_group("chests")
	_chests_to_open = chests.size()
	for chest in chests:
		chest.on_opened.connect(_on_chest_opened)


func _init_cameras():
	var cameras = get_tree().get_nodes_in_group("security cameras")
	for camera in cameras:
		camera.on_player_catch.connect(_on_player_caught_by_camera)


func _init_guards():
	var guards = get_tree().get_nodes_in_group("guards")
	for guard in guards:
		guard.on_player_catch.connect(_on_player_caught_by_guard)


func _finish_entered(body):
	if is_level_completed() and body is Player:
		player.disabled = true
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_packed(next_level)


func _on_chest_opened():
	_chests_to_open -= 1


func is_level_completed() -> bool:
	return _chests_to_open == 0


func _on_player_caught_by_camera():
	await get_tree().create_timer(0.2).timeout
	_you_failed()


func _on_player_caught_by_guard():
	await get_tree().create_timer(0.2).timeout
	_you_failed()


func _you_failed():
	var audioPlayer = AudioStreamPlayer.new()
	add_child(audioPlayer)
	audioPlayer.stream = ohoh
	audioPlayer.volume_db = -5
	audioPlayer.play()

	player.disabled = true
	await audioPlayer.finished
	await get_tree().create_timer(0.3).timeout
	const youFailedScene = preload("res://scenes/YouFailed.tscn")
	add_child(youFailedScene.instantiate())

	await get_tree().create_timer(.5).timeout
	audioPlayer.queue_free()
	get_tree().reload_current_scene()
