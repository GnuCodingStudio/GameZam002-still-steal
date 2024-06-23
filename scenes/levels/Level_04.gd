extends BasicLevel

func _on_player_catch():
	print('Lose...')
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/YouFailed.tscn")
