extends Control

export (NodePath) var level_path
onready var level = get_node(level_path)

func _ready():
	$counter/timer.connect("timeout", level, "_on_timer_timeout")
	
func uncomplete():
	for c in get_children():
		c.hide()
	$uncompleted.show()

func _on_retry_button_up():
	get_tree().reload_current_scene()