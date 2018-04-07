extends Node2D
export (NodePath) var icons_path
onready var icons_node = get_node(icons_path)

export (NodePath) var score_path
onready var score_node = get_node(score_path)

var can_interact = false

func _process(delta):
	if can_interact:
		if Input.is_action_pressed("interact"):
			$progress_bar.value += 100 * delta
		if Input.is_action_just_released("interact"):
			$progress_bar.value = 0

func _on_area_entered(area):
	if area.is_in_group("player"):
		can_interact = true
		$progress_bar.value = 0
		$progress_bar.show()

func _on_area_exited(area):
	if area.is_in_group("player"):
		can_interact = false
		$progress_bar.value = 0
		$progress_bar.hide()

func _on_progress_bar_value_changed(value):
	if value >= 100:
		if icons_node.get_child_count() > 0:
			icons_node.get_child(icons_node.get_child_count() -1).queue_free()
			score_node.set_score(value, score_node.ADD)
		if icons_node.get_child_count() > 1:
			$progress_bar.value = 0