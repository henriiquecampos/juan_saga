extends Node2D
var index = 1

export (NodePath) var bug_path
onready var bug_node = get_node(str(bug_path)+"/bugs")
func _ready():
	if score_container.already_played:
		return
	$dialog_box/next.grab_focus()
	$dialog_box/next.connect("button_up", self, "_on_next_button_up")

func _on_next_button_up():
	if $animator.current_animation_position < $animator.current_animation_length:
		$animator.seek($animator.current_animation_length)
		return
	index += 1
	var list = $animator.get_animation_list()
	if index <= list.size() - 1:
		$animator.play(list[index])
	else:
		_toggle_tree_pause()
		queue_free()

func _toggle_tree_pause():
	get_tree().paused = !get_tree().paused
	

func _on_animation_finished(anim_name):
	$dialog_box/next.text = "next"


func _on_animation_started(anim_name):
	$dialog_box/next.text = "skip"

func find_latest_bug():
	var bug_position = bug_node.get_child(bug_node.get_child_count() -1).global_position
	$tween.interpolate_property($pivot, "global_position", $pivot.global_position, bug_position,
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	$tween.start() 

func hit_latest_bug():
	var bug = bug_node.get_child(bug_node.get_child_count() -1)
	if !bug is load("res://actors/enemies/screen_bug.gd"):
		return
	bug.damage_health(1)
	
func find_first_bug():
	var bug = $"../bugs".get_child(1)
	var bug_position = bug.global_position
	$tween.interpolate_property($pivot, "global_position", $pivot.global_position, bug_position,
		0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	$tween.start() 
	
func hit_first_bug():
	var bug = $"../bugs".get_child(1)
	if !bug is load("res://actors/enemies/ground_bug.gd"):
		return
	bug.damage_health(1)