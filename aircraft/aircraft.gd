class_name Aircraft
extends Area2D

signal shot

@export var health: float
@export var speed: float
@export var crash_damage: float

@export var can_shoot: bool
@export var bullet_scene: PackedScene

@onready var gun_timer := $GunTimer
@onready var muzzle := $Muzzle

var velocity: Vector2
var is_alive := true


func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	control(delta)


func control(delta: float) -> void:
	pass


func shoot() -> void:
	pass


func hit(damage: float) -> void:
	health -= damage
	if health <= 0.0:
		die()


func die() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("hit"):
		area.hit(crash_damage)


func _on_gun_timer_timeout() -> void:
	can_shoot = true
