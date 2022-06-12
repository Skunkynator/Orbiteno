extends Node2D
class_name Rotator


export var speed : float = 1


func _process(delta: float) -> void:
	rotate(delta * speed * PI)
