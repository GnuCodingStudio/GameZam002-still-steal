extends BasicLevel

@onready var finish = %FinishArea


func _on_body_entered(body):
	if (body is Player):
		print('Finish')
