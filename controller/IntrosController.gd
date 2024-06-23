extends Node


var _last_intro_played: int = -1


func on_intro_played(id: int):
	_last_intro_played = id


func can_play(id: int) -> bool:
	return _last_intro_played < id
