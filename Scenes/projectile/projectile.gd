class_name Projectile

extends CharacterBody2D

signal destroyed()

@export var speed: float = 300
@export var direction: Vector2 = Vector2.UP


func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision != null:
		var collider: Object = collision.get_collider()
		
		if collider.has_method("hit"):
			collider.hit()
			
		destroyed.emit()
		queue_free()
