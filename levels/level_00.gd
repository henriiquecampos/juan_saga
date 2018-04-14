extends Node2D
export (String, FILE, "*.tscn") var next_level
export (String, FILE, "*.tscn") var current_level
export (int) var min_score = 0

func _ready():
	$rocket.set_minimum_score(min_score)
	score_container.next_level = next_level
	score_container.current_level = current_level
	$rocket.connect("tree_exited", self, "_on_rocket_tree_exited")
	yield($screen/game_screen/animator, "animation_finished")
	if !score_container.already_played:
		$tutoring/animator.play("tutoring_00")
	
func _on_timer_timeout():
	get_tree().set_pause(true)
	if $interface/hud/score.score < min_score:
		$animator.play("release")
		yield($animator, "animation_finished")
		$interface/hud.uncomplete()
		return
	$animator.play("release")
	yield($animator, "animation_finished")
	$camera.tween_position()
	yield($camera/tween, "tween_completed")
	$rocket.launch()

func _on_rocket_tree_exited():
	$screen/game_screen.change_scene()