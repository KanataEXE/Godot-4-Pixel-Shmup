class_name Enemy
extends Aircraft

@export var score: int

var target: Player = null


func control(delta: float) -> void:
	
	velocity = Vector2.DOWN * speed * delta
	
	position += velocity
	
	if target and can_shoot:
		shoot()


func shoot() -> void:
	can_shoot = false
	gun_timer.start()
	
	var target_position = target.global_position
	var muzzle_position = muzzle.global_position
	var direction = (target_position - muzzle_position).normalized()
	
	shot.emit(bullet_scene, muzzle, direction)


func die() -> void:
	GameData.score += score
	is_alive = false
	animation_player.play("explosion")
	await animation_player.animation_finished
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	can_shoot = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_detect_area_area_entered(area: Area2D) -> void:
	if area is Player:
		target = area


func _on_detect_area_area_exited(area: Area2D) -> void:
	if area is Player:
		target = null
