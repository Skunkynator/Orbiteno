tool
extends Area2D


export var obj_size := Vector2(10,10) setget set_obj_size
var shape : RectangleShape2D
var mesh_inst : MeshInstance2D
var mesh : QuadMesh


func _ready() -> void:
	mesh = QuadMesh.new()
	shape = RectangleShape2D.new()
	mesh.size = obj_size
	shape.extents = obj_size / 2
	var col_shape := get_node_or_null("Collision") as CollisionShape2D
	if col_shape:
		col_shape.shape = shape
	var mesh_inst = get_node_or_null("Visual") as MeshInstance2D
	if mesh_inst:
		mesh_inst.mesh = mesh
	if not Engine.editor_hint:
		set_script(null)


func set_obj_size(size : Vector2) -> void:
	if mesh:
		mesh.size = size
	if shape:
		shape.extents = size / 2
	obj_size = size
	property_list_changed_notify()
