extends Node2D


signal finished


export var speed : float = 300
var height : float = 1
var moving : bool = true


func _ready() -> void:
	var end := get_node_or_null("End") as Node2D
	if not end:
		printerr("No End node defined for Level!")
		queue_free()
		return
	height = -end.position.y + 1080


func _process(delta: float) -> void:
	if moving:
		position.y += delta * speed
		if position.y > height:
			moving = false
			emit_signal("finished")


func scroll_to_start() -> void:
	var time := 2.0
	moving = false
	$Tween.interpolate_property(self,"position:y",null,0,time,Tween.TRANS_BACK)
	$Tween.start()
	yield(get_tree().create_timer(time),"timeout")
	moving = true
