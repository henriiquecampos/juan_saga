extends "res://actors/platform_actors/player_platform_character.gd"

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