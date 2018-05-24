extends Label

onready var t = get_text()
func _process(delta):
	text = t.format({"time":int($timer.time_left)})