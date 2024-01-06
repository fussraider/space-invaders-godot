class_name Bunker
extends StaticBody2D

@export var lives: int = 10

func destroy() -> void:
	queue_free()


func hit() -> void:
	lives -= 1
	if lives <=0 :
		destroy()
