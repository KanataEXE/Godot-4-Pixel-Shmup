extends Node2D

@export var enemy_scene: PackedScene

@onready var game_over_screen := $UILayer/GameOverScreen
@onready var spawn_timer := $SpawnTimer
@onready var enemies := $Enemies
@onready var bullets := $Bullets


func _on_spawn_timer_timeout() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	enemies.add_child(enemy)
	
	enemy.global_position.y = -64
	enemy.global_position.x = randi() % 353 + 16
	
	enemy.connect("shot", _on_aircraft_shot)


func _on_aircraft_shot(bullet_scene: PackedScene, muzzle: Marker2D, direction: Vector2) -> void:
	var bullet: Area2D = bullet_scene.instantiate()
	bullets.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	bullet.direction = direction
	bullet.global_rotation = direction.angle()


func _on_game_over_screen_restarted() -> void:
	GameData.lives = 3
	get_tree().reload_current_scene()


func _on_player_died() -> void:
	spawn_timer.stop()
	game_over_screen.show()
