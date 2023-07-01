extends Node2D


signal died


@export var rotator_path : NodePath
@export var ball_area_paths : Array[NodePath]
@export var rot_speed : float
var rotator : Node2D
var touches : Dictionary
var touch_sum : int
var dead := false


func _ready():
	rotator = get_node_or_null(rotator_path) as Node2D
	if not rotator:
		queue_free()
	for path in ball_area_paths:
		var area := get_node_or_null(path) as Area2D
		if not area:
			continue
		area.connect("area_entered", wall_entered)


func _notification(what: int) -> void:
	if what == NOTIFICATION_UNPAUSED:
		touches.clear()
		touch_sum = 0


func _input(event : InputEvent):
	if event is InputEventScreenTouch:
		if not event.pressed and event.index in touches:
			touch_sum -= touches[event.index]
			touches.erase(event.index)
		elif event.pressed and not event.index in touches:
			touches[event.index] = -1 if event.position.x < 360 else 1
			touch_sum += touches[event.index]


func _process(delta: float) -> void:
	if not dead:
		rotator.rotate(sign(touch_sum) * delta * rot_speed)


func wall_entered(wall) -> void:
	if not dead:
		emit_signal("died")


func reset_rotator() -> void:
	var time := 2.0
	create_tween()\
			.tween_property(rotator,"rotation",0.0,time)\
			.set_trans(Tween.TRANS_BACK)
	dead = true
	await get_tree().create_timer(time).timeout
	dead = false

