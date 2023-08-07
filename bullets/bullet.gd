class_name Bullet
extends Area2D

@export var speed: float
@export var damage: float

var direction: Vector2


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(damage)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
