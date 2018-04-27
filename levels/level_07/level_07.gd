extends "res://levels/level_00/level_00.gd"
func _ready():
	$juan.set_process_input(false)
	$screen/game_screen/animator.connect("animation_finished", 
		self, "_on_game_screen_animation_finished")

func _on_dialogue_changed(to):
	match to:
		0:
			get_tree().set_pause(true)
		3:
			yield($dialogue/control/dialogue_box/button, "button_up")
			var target_pos = $bugs/boss_bug.global_position
			target_pos.y += - 200
			$camera.tween_position(target_pos)
		4:
			yield($dialogue/control/dialogue_box/button, "button_up")
			$spawner.can_spawn = true
			$juan.set_process_input(true)
			get_tree().set_pause(false)