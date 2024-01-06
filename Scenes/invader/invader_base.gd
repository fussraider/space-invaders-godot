class_name InvaderBase

extends StaticBody2D

signal killed

@onready var rayCastLeft: RayCast2D = $RayCast2DLeft
@onready var rayCastRight: RayCast2D = $RayCast2DRight
@onready var rayCastDown: RayCast2D = $RayCast2DDown


func _physics_process(delta: float) -> void:
	if rayCastLeft.is_colliding():
		var leftCollider: Object = rayCastLeft.get_collider()
		
		if leftCollider is Bunker:
			leftCollider.destroy()
		elif leftCollider != null:
			get_tree().call_group("invaders", "change_direction")
	
	elif rayCastRight.is_colliding():
		var rightCollider: Object = rayCastRight.get_collider()
		
		if rightCollider is Bunker:
			rightCollider.destroy()
		elif rightCollider != null:
			get_tree().call_group("invaders", "change_direction")
	elif rayCastDown.is_colliding():
		var downCollider: Object = rayCastDown.get_collider()
		
		if downCollider is Bunker or downCollider is Player:
			downCollider.destroy()
		
	
func hit() -> void:
	killed.emit()
	queue_free()
