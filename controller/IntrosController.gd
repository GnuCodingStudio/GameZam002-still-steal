extends Node


var _last_intro_played: String


func on_intro_played(id: String):
	_last_intro_played = id


func can_play(id: String) -> bool:
	return _last_intro_played != id
