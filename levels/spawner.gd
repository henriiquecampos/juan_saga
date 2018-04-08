extends Position2D

export (float) var min_time = 3.0
export (float) var max_time = 8.0

const BUG = preload("res://actors/enemies/ground_bug.tscn")

func _ready():
	randomize()
	$timer.set_wait_time(rand_range(min_time, max_time))
	$timer.connect("timeout", self, "_spawn")
	$timer.start()

func _spawn():
	var s = BUG.instance()
	s.global_position = global_position
	$"../bugs".add_child(s)
	$timer.set_wait_time(rand_range(min_time, max_time))
	$timer.start()