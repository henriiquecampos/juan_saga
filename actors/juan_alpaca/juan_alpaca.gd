extends "res://actors/platform_actors/player_platform_character.gd"

onready var initial_speed = walk_speed
onready var animator = $cutout_character/animator
func _on_state_changed(from, to):
	match to:
		WALK:
			animator.play("walk")
		IDLE:
			animator.play("idle")
		FALL:
			animator.play("fall")
		JUMP:
			animator.play("jump")
			$sfx.play()

func _on_bugs_new_child(penalty):
	walk_speed -= penalty
#	$debug.visible = $bugs.get_child_count() > 1
	
func _input(event):
	if event.is_action_pressed("interact"):
		$bugs.damage_child()