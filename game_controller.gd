extends Node


var current_level : String 
var conf := {
	last_level = "",
	world_progress = [
	]
}
var worlds : WorldList = preload("res://levels/worlds.tres")
var game : PackedScene = preload("res://menu/game_ui.tscn")
var menu : PackedScene = preload("res://menu/title.tscn")


func _ready() -> void:
	var conf_file := File.new()
	if conf_file.file_exists("user://save.conf"):
		conf_file.open("user://save.conf",File.READ)
		conf = str2var(conf_file.get_as_text()) as Dictionary
		conf_file.close()
		current_level = conf["last_level"]
	else:
		save_current()


func save_current() -> void:
	var conf_file := File.new()
	conf_file.open("user://save.conf",File.WRITE)
	conf_file.store_string(var2str(conf))
	conf_file.close()


func load_level(level : String) -> void:
	current_level = level
	load_current_level()


func load_current_level() -> void:
	var level := worlds.get_level(current_level)
	if not level:
		level = worlds.cur_worlds[0].levels[0]
	var level_controller : LeveLController = game.instance()
	add_child(level_controller)
	level_controller.load_level(level)


func update_current_level(world_index : int, lvl_index : int) -> void:
	var cur_world : WorldInfo = worlds.cur_worlds[world_index]
	var cur_level : LevelInfo = cur_world.levels[lvl_index]
	current_level = cur_world.Name + "-" + cur_level.Name
	save_current()

func finished(level_idx : int, world_idx : int):
	pass


func load_main() -> void:
	remove_child(get_child(0))
	add_child(menu.instance())
