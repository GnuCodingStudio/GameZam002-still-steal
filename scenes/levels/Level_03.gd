extends BasicLevel

@onready var intro: AudioStreamPlayer = %Intro

func _init_level():
	if IntrosController.can_play(3):
		IntrosController.on_intro_played(3)
		player.disabled = true
		intro.play()
		await intro.finished
		player.disabled = false
