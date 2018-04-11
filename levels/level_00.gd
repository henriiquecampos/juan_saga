extends Node2D
export (String, FILE, "*.tscn") var next_level

func _ready():
	score_container.next_level = next_level
	$rocket.connect("tree_exited", self, "_on_rocket_tree_exited")
	yield($screen/game_screen/animator, "animation_finished")
	if !score_container.already_played:
		$tutoring/animator.play("tutoring_00")
	
func _on_timer_timeout():
	get_tree().set_pause(true)
	$animator.play("release")
	yield($animator, "animation_finished")
	$juan/camera.tween_position()
	yield($juan/camera/tween, "tween_completed")
	$rocket.launch()

func _on_rocket_tree_exited():
	$screen/game_screen.change_scene()