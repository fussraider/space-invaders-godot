class_name MysteryShips
extends Node2D

signal mystery_ship_killed(points: int)

@onready var spawnTimer: Timer = $SpawnTimer

@export var mysteryShipScene: PackedScene
@export var pointsPerKill: int = 100


func _ready() -> void:
	spawnTimer.connect("timeout", on_spawn_timer_timeout)
	spawnTimer.start()

func spawn_mystery_ship() -> void:
	var mysteryShip: MysteryShip = mysteryShipScene.instantiate()
	mysteryShip.connect("killed", on_mystery_ship_killed)
	add_child(mysteryShip)

func on_spawn_timer_timeout() -> void:
	if randf() <= 0.5:
		spawn_mystery_ship()
	else:
		spawnTimer.start()

func on_mystery_ship_killed() -> void:
	mystery_ship_killed.emit(pointsPerKill)
	spawnTimer.start()
