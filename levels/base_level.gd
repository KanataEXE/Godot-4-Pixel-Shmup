extends Node2D

@export var enemy_scene: PackedScene

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
