tool
extends TileMap

export (bool) var trigger = false setget set_trigger
export (int) var unwanted_index = 0
export (int) var wanted_index = 0
func set_trigger(value):
	if value:
		rebuild_tiles()
	
func rebuild_tiles():
	for v in get_used_cells():
		if get_cellv(v) == unwanted_index:
			set_cellv(v, wanted_index)