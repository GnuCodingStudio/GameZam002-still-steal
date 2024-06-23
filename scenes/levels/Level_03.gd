extends BasicLevel

@onready var intro: AudioStreamPlayer = %Intro

func _init_level():
	player.disabled = true
	intro.play()
	await intro.finished
	player.disabled = false
