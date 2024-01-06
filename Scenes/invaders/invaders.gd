class_name Invaders
extends Node2D

signal invader_killed(points: int)
signal all_invaders_killed

@export var invaderScenes: Array[PackedScene] = []
@export var missileScene: PackedScene
@export var pointsPerKill: int = 10
@export var rows: int = 5
@export var columns: int = 11
@export var offset: float = 35.0
@export var speed: Curve
@export var rowStep: int = 8

var direction: Vector2 = Vector2.RIGHT
var amountKilled: int = 0;
var amountAlive: int: 
	get: return totalInvaders - amountKilled
var percentKilled: float:
	get: return float(amountKilled) / float(totalInvaders)
var totalInvaders: int:
	get: return rows * columns

@onready var blockTimer: Timer = $BlockTimer
@onready var attackTimer: Timer = $AttackTimer


func _ready() -> void:
	for row: int in range(rows):
		var width: float = offset * (columns - 1)
		var height: float = offset * (rows - 1)
		
		var centering: Vector2 = Vector2(-width / 2, -height / 2)
		var rowPosition: Vector2 = Vector2(centering.x, centering.y + (row * offset))
		
		for col: int in range(columns):
			var invader: InvaderBase = invaderScenes[row].instantiate()
			var invaderPosition: Vector2 = rowPosition
			invaderPosition.x += col * offset
			invader.position = invaderPosition 
			invader.connect("killed", on_invader_killed)
			
			add_child(invader)
			
	attackTimer.connect("timeout", on_attack_timer_timeout)


func _physics_process(delta: float) -> void:
	position += speed.sample_baked(percentKilled) * delta * direction


func change_direction() -> void:
	if blockTimer.time_left > 0:
		return
		
	direction.x *= -1
	global_position.y += rowStep
	blockTimer.start()

func missile_attack() -> void:
	for invader: InvaderBase in get_tree().get_nodes_in_group("invader"):
		if amountAlive > 0 && randf() <= 1.0 / float(amountAlive):
			var missile: Projectile = missileScene.instantiate()
			missile.position = invader.global_position
			
			add_child(missile)
			
			break


func on_invader_killed() -> void:
	amountKilled += 1
	invader_killed.emit(pointsPerKill)
	
	if amountAlive <= 0:
		all_invaders_killed.emit()
	
func on_attack_timer_timeout() -> void:
	missile_attack()
