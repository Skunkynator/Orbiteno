extends PathFollow2D
class_name AutoPathFollow2D


@export var speed : float = 1


func _process(delta: float) -> void:
	h_offset += delta * speed * 500
