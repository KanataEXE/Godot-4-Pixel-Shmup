class_name Enemy
extends Aircraft


func control(delta: float) -> void:
	
	velocity = Vector2.DOWN * speed * delta
	
	position += velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
