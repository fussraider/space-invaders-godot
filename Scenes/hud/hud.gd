class_name Hud
extends CanvasLayer

@onready var scoreValue: Label = $MarginContainer/VBoxContainer/HBoxContainer/ScoreValue
@onready var livesValue: Label = $MarginContainer/VBoxContainer/HBoxContainer/LivesValue

func set_score(value: int) -> void:
	scoreValue.text = str(value)
	
func set_lives(value: int) -> void:
	livesValue.text = str(value)
