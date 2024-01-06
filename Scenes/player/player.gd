class_name Player
extends CharacterBody2D

signal player_damage
signal player_destroyed

@export var laserScene: PackedScene
@export var speed: float = 150.0

var laserActive: bool = false

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("ui_accept"):
		shot()

	move_and_slide()

func shot() -> void:
	if !laserActive:
		var laser: Projectile = laserScene.instantiate()
		
		laser.position = position
		laser.connect("destroyed", laser_destroyed)
		laserActive = true
		
		add_child(laser)

func laser_destroyed() -> void:
	laserActive = false
	
func hit() -> void:
	player_damage.emit()
	
func destroy() -> void:
	player_destroyed.emit()
	
