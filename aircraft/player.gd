class_name Player
extends Aircraft

const MINIMUM_SCREEN_LIMIT := Vector2(0 + 16, 0 + 16)
const MAXIMUM_SCREEN_LIMIT := Vector2(384 - 16, 512 - 16)

@onready var invincibility_timer := $InvincibilityTimer

var input_direction: Vector2


func control(delta: float) -> void:
	input_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = input_direction.normalized() * speed * delta
	
	position += velocity
	
	global_position.x = clamp(global_position.x, MINIMUM_SCREEN_LIMIT.x, MAXIMUM_SCREEN_LIMIT.x)
	global_position.y = clamp(global_position.y, MINIMUM_SCREEN_LIMIT.y, MAXIMUM_SCREEN_LIMIT.y)
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()


func shoot() -> void:
	can_shoot = false
	gun_timer.start()
	var direction := Vector2.UP
	shot.emit(bullet_scene, muzzle, direction)


func hit(damage: float) -> void:
	if invincibility_timer.is_stopped():
		health -= damage
		if health <= 0.0:
			die()
		else:
			animation_player.play("hit")


func die() -> void:
	is_alive = false
	animation_player.play("explosion")
	await animation_player.animation_finished
	
	GameData.lives -= 1
	
	if GameData.lives >= 0:
		is_alive = true
		invincibility_timer.start()
		animation_player.play("Players/respawn")
	else:
		pass


func _on_invincibility_timer_timeout() -> void:
	animation_player.play("RESET")
