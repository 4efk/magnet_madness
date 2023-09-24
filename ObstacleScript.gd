extends Area2D


func _on_body_entered(body):
	if body.name == 'Player':
		body.die()


func _on_area_entered(area):
	if area.name == 'DeleteArea':
		get_parent().queue_free()
