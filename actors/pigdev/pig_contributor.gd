extends Node2D
export (NodePath) var level_bugs
export (NodePath) var level_computer
export (int) var bugs_tolerance = 1
onready var bugs = get_node(level_bugs)
onready var computer = get_node(level_computer)

func _ready():
	$timer.connect("timeout", self, "_on_timeout")
	
func _on_timeout():
	if bugs.bugs_count() > bugs_tolerance:
		return
	computer.bump()
	$"../spawner"._spawn()
	$cutout_character/animator.play("bug")
	yield($cutout_character/animator, "animation_finished")
	$cutout_character/animator.play("coding")

func _on_bugs_new_child(penalty, child_amount):
#	if child_amount <= bugs_tolerance:
#		$timer.start()
	pass
