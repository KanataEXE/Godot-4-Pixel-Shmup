extends Node2D

@onready var bullets := $Bullets

func _on_aircraft_shot(bullet_scene: PackedScene, muzzle: Marker2D, direction: Vector2) -> void:
	var bullet: Area2D = bullet_scene.instantiate()
	bullets.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	bullet.direction = direction
	bullet.global_rotation = direction.angle()
