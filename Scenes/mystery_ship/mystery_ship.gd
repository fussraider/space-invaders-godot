class_name MysteryShip
extends StaticBody2D

signal killed

@export var speed: int = 200
@export var direction: Vector2 = Vector2.RIGHT

@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rayCastLeft.is_colliding() || rayCastRight.is_colliding():
		change_direction()
	
	position += speed * delta * direction


func change_direction() -> void:
	direction.x *= -1

func hit() -> void:
	killed.emit()
	queue_free()
