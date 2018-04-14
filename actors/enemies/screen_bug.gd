extends Node2D
export (int) var health = 3 setget set_health
export (int) var damage = 5
export (int) var penalty = 5
export (int) var score = 15
func _ready():
	get_parent().emit_signal("new_child", penalty)
	$button.connect("button_up", self, "damage_health", [1])
	$timer.set_wait_time(rand_range(0.5, 2))
	connect("tree_exited", get_parent(), "_on_screen_bug_tree_exited", [self])
	$timer.connect("timeout", get_parent(), "_on_screen_bug_timeout", [self])
	$timer.connect("timeout", $animator, "play", ["damage"])

func set_health(value):
	health = value
	if health < 1:
		get_parent().get_node("sfx").position = position
		queue_free()

func damage_health(amount):
	set_health(health - amount)