extends Node

signal score_updated
signal life_updated

var score: int = 0:
	set(value):
		score = value
		score_updated.emit(score)

var lives: int = 3:
	set(value):
		lives = value
		life_updated.emit(lives)
