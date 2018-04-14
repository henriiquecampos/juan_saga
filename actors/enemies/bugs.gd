extends Node2D

onready var score_node = get_tree().get_nodes_in_group("score")[0]
signal new_child(penalty)

func _on_screen_bug_tree_exited(bug):
	$sfx.play()
	emit_signal("new_child", -bug.penalty)
	score_node.set_score(bug.score, score_node.ADD)

func _on_screen_bug_timeout(bug):
	score_node.set_score(bug.damage, score_node.REMOVE)
	
func damage_child():
	if get_child_count() <= 1:
		return
	
	var c = get_child(get_child_count() -1)
	if c.has_method("damage_health"):
		c.damage_health(1)