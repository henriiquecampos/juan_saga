extends Node2D

onready var score_node = get_tree().get_nodes_in_group("score")[0]

func _on_screen_bug_tree_exited():
	score_node.set_score(15, score_node.ADD)
	
func _on_screen_bug_timeout():
	score_node.set_score(5, score_node.REMOVE)