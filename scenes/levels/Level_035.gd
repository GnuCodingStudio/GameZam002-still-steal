extends BasicLevel

@onready var intro: AudioStreamPlayer = %Intro

func _init_level():
	if IntrosController.can_play(4):
		IntrosController.on_intro_played(4)
		#player.disabled = true
		#intro.play()
		#await intro.finished
		player.disabled = false
