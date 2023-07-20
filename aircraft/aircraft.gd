class_name Aircraft
extends Area2D

@export var health: float
@export var speed: float

var velocity: Vector2
var is_alive := true


func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	control(delta)


func control(delta: float) -> void:
	pass
