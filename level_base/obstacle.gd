@tool
extends Area2D


@export var obj_size := Vector2(10,10): set = set_obj_size
var shape : RectangleShape2D
var visual : Node2D


func _ready() -> void:
	shape = RectangleShape2D.new()
	var col_shape := get_node_or_null("Collision") as CollisionShape2D
	if col_shape:
		col_shape.shape = shape
	visual = get_node_or_null("Visual") as Node2D
	set_obj_size(obj_size)
	if not Engine.is_editor_hint():
		set_script(null)


func set_obj_size(size : Vector2) -> void:
	if visual:
		visual.scale = size
	if shape:
		shape.size = size
	obj_size = size
	notify_property_list_changed()
