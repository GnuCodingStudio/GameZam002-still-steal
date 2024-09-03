extends Area2D

signal player_detected


var _player: Player


func _process(delta):
	if _player != null:
		if _can_see(_player):
			player_detected.emit()


func _on_body_entered_detector(body):
	if body is Player:
		_player = body


func _on_body_exited_detector(body):
	if body is Player:
		_player = null


## Check if guard can see the body or if there something between them
func _can_see(player: Player) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.hit_from_inside = true
	query.collision_mask = collision_mask
	var result = space_state.intersect_ray(query)
	return result.has("collider") and result["collider"] == player
