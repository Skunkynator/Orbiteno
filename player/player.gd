extends Node2D


signal died


export var rotator_path : NodePath
export(Array,NodePath) var ball_area_paths : Array
export var rot_speed : float
var rotator : Node2D
var touches : Dictionary
var touch_sum : int
var dead := false


# Called when the node enters the scene tree for the first time.
func _ready():
	rotator = get_node_or_null(rotator_path) as Node2D
	if not rotator:
		queue_free()
	for path in ball_area_paths:
		var area := get_node_or_null(path) as Area2D
		if not area:
			continue
		area.connect("area_entered",self,"wall_entered")


func _input(event):
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
	$Tween.interpolate_property(rotator,"rotation",null,0,time,Tween.TRANS_BACK)
	$Tween.start()
	dead = true
	yield(get_tree().create_timer(time),"timeout")
	dead = false
