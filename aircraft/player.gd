class_name Player
extends Aircraft

const MINIMUM_SCREEN_LIMIT := Vector2(0 + 16, 0 + 16)
const MAXIMUM_SCREEN_LIMIT := Vector2(384 - 16, 512 - 16)

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
