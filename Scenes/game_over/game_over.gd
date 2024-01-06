class_name GameOver
extends CanvasLayer

@export var is_win: bool = false
@export var score: int = 0

@onready var resultScore: Label = $MarginContainer/VBoxContainer/ResultScoreLabel
@onready var resultTitle: Label = $MarginContainer/VBoxContainer/ResultTitleLabel
@onready var restartBtn: Button = $MarginContainer/VBoxContainer/RestartButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_win:
		resultTitle.text = "You Win!"
	else:
		resultTitle.text = "Game Over"
		
	resultScore.text = str(score)
	
	restartBtn.connect("button_down", on_restart_btn_button_down)


func on_restart_btn_button_down() -> void:
	get_tree().reload_current_scene()
