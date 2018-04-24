extends Node2D
export (String, FILE, "*.tscn") var next_level
export (String, FILE, "*.tscn") var current_level
export (int) var min_score = 0
const BGM_MUSIC = preload("res://assets/bgm/background_music.ogg")

func _ready():
	if !bgm.stream == BGM_MUSIC:
		bgm.stream = BGM_MUSIC
		bgm.get_node("animator").play("fade")
		bgm.play()
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
	score_container.scene_score = $interface/hud/score.score
	score_container.set_score(score_container.scene_score, score_container.ADD)
	$animator.play("release")
	yield($animator, "animation_finished")
	$camera.tween_position()
	yield($camera/tween, "tween_completed")
	$rocket.launch()

func _on_rocket_tree_exited():
	$screen/game_screen.change_scene()