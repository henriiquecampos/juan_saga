extends Control

export (NodePath) var level_path
onready var level = get_node(level_path)

func _ready():
	$counter/timer.connect("timeout", level, "_on_timer_timeout")