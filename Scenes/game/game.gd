class_name Game
extends Node2D

@export var lives: int = 3
@export var score: int = 0

@onready var mysteryShips: MysteryShips = $MysteryShips
@onready var invaders: Invaders = $Invaders
@onready var player: Player = $Player
@onready var hud: Hud = $HUD

var gameOverScene: PackedScene = preload("res://Scenes/game_over/game_over.tscn")


func _ready() -> void:
	mysteryShips.connect("mystery_ship_killed", update_score)
	invaders.connect("invader_killed", update_score)
	invaders.connect("all_invaders_killed", on_all_invaders_killed)
	player.connect("player_damage", on_player_damage)
	player.connect("player_destroyed", on_player_destroyed)
	hud.set_lives(lives)
	hud.set_score(score)


func update_score(value: int) -> void:
	score += value
	hud.set_score(score)


func update_lives(value: int) -> void:
	lives += value
	hud.set_lives(lives)
	
	if lives <= 0:
		game_over(false)


func game_over(is_win: bool) -> void:
	mysteryShips.queue_free()
	invaders.queue_free()
	player.queue_free()
	hud.queue_free()
	
	var gameOver: GameOver = gameOverScene.instantiate()
	gameOver.score = score
	gameOver.is_win = is_win
	
	add_child(gameOver)


func on_player_damage() -> void:
	update_lives(-1)


func on_player_destroyed() -> void:
	update_lives(-lives)


func on_all_invaders_killed() -> void:
	game_over(true)
