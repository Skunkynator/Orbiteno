extends PathFollow2D
class_name AutoPathFollow2D


export var speed : float = 1


func _process(delta: float) -> void:
	offset += delta * speed * 500
