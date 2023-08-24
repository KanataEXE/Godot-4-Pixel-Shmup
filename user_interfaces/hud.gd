extends MarginContainer

@onready var score_value := $ScoreLifeContainer/ScoreContainer/ScoreValue
@onready var life_container := $ScoreLifeContainer/LifeContainer

@export var player_life_scene: PackedScene


func _ready() -> void:
	GameData.connect("score_updated", set_score_value)
	GameData.connect("life_updated", set_player_lives)
	
	set_player_lives(GameData.lives)


func set_score_value(value: int) -> void:
	score_value.text = "%06d" % value
	score_value.show()


func set_player_lives(value: int) -> void:
	for child in life_container.get_children():
		child.queue_free()
	
	for i in value:
		var player_life := player_life_scene.instantiate()
		life_container.add_child(player_life)
