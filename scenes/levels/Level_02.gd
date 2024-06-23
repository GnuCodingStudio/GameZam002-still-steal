extends BasicLevel

@onready var intro: AudioStreamPlayer = %Intro

func _init_level():
	if IntrosController.can_play(2):
		IntrosController.on_intro_played(2)
		player.disabled = true
		intro.play()
		await intro.finished
		player.disabled = false
