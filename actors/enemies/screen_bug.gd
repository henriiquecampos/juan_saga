extends Node2D
var health = 3 setget set_health
func _ready():
	$button.connect("button_up", self, "set_health", [-1])
	$timer.set_wait_time(rand_range(0.5, 2))
	connect("tree_exited", get_parent(), "_on_screen_bug_tree_exited")
	$timer.connect("timeout", get_parent(), "_on_screen_bug_timeout")
	$timer.connect("timeout", $animator, "play", ["damage"])

func set_health(value):
	if health > 1:
		health += value
	else:
		queue_free()