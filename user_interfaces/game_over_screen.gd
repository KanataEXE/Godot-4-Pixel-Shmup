extends MarginContainer

signal restarted


func _on_button_pressed() -> void:
	restarted.emit()
