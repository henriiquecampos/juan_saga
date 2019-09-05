extends "res://screens/basic_screen.gd"

func _ready():
	next_scene = score_container.next_level

func _on_retry_button_up():
	score_container.score -= score_container.scene_score
	next_scene = score_container.current_level
	change_scene()
