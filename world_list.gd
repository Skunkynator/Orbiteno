extends Resource
class_name WorldList


export(Array, Resource) var cur_worlds : Array


func get_level(name : String) -> LevelInfo:
	if not name:
		return null
	var name_arr = name.split("-")
	var world : WorldInfo
	for idx_w in cur_worlds.size():
		if cur_worlds[idx_w].name == name_arr[0]:
			world = cur_worlds[idx_w]
			break
	for idx_l in world.levels.size():
		if world.levels[idx_l].name == name_arr[1]:
			return world.levels[idx_l]
	return null


func get_level_index(level : LevelInfo) -> Array:
	var idx_arr := []
	for idx_w in cur_worlds.size():
		var found : int = cur_worlds[idx_w].levels.find(level)
		if found != -1:
			idx_arr = [idx_w, found]
	return idx_arr
