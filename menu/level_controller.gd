extends Control
class_name LeveLController


var level_index : int
var world_index : int
var world_info : WorldInfo
var current_lvl : Node
var player : Node2D


func pause() -> void:
	get_tree().paused = !get_tree().paused
	$PauseMenu.visible = !$PauseMenu.visible


func load_level(level : LevelInfo):
	if current_lvl:
		current_lvl.queue_free()
	if not player:
		player = get_node_or_null("ViewportContainer/Viewport/Player")
		player.connect("died",self,"on_player_died")
	var idx : Array = GameController.worlds.get_level_index(level)
	world_index = idx[0]
	level_index = idx[1]
	current_lvl = level.levelFile.instance()
	$ViewportContainer/Viewport.add_child(current_lvl)
	current_lvl.connect("finished",self,"load_next_level")
	world_info = GameController.worlds.cur_worlds[world_index]


func load_next_level() -> void:
	level_index += 1
	if level_index >= world_info.levels.size():
		level_index = 0
		world_index += 1
		if world_index >= GameController.worlds.cur_worlds.size():
			GameController.load_main()
			queue_free()
			return
		world_info = GameController.worlds.cur_worlds[world_index]
	reset_player()
	yield(get_tree().create_timer(2),"timeout")
	load_level(world_info.levels[level_index])


func reset_player() -> void:
	player.reset_rotator()


func on_player_died() -> void:
	current_lvl.scroll_to_start()
	reset_player()
