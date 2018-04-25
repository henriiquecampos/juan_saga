extends Node2D
export (NodePath) var level_bugs
onready var bugs = get_node(level_bugs)

func _ready():
	$timer.connect("timeout", self, "_on_timeout")
	
func _on_timeout():
	if bugs.bugs_count() > 1:
		$timer.stop()
	$cutout_character/animator.play("bug")
	yield($cutout_character/animator, "animation_finished")
	$cutout_character/animator.play("coding")

func _on_bugs_new_child(penalty, child_amount):
	print("bugs children: %s"%child_amount)
	if child_amount <= 1:
		$timer.start()
