extends "res://levels/level_00/level_00.gd"

func _ready():
	$juan.set_process_input(false)
	$screen/game_screen/animator.connect("animation_finished", 
		self, "_on_game_screen_animation_finished")
		
func _on_dialogue_changed(to):
	match to:
		0:
			get_tree().set_pause(true)
		1:
			$pig_contributor/cutout_character/animator.play("coding")
		2:
			$computer.bump()
		3:
			yield($dialogue/control/dialogue_box/button, "button_up")
			$pig_contributor/cutout_character/animator.play("bug")
			$bugs/ground_bug.show()
			$bugs/spawn_particle.set_emitting(true)
			$bugs/spawn_particle/timer.start()
			yield($pig_contributor/cutout_character/animator, "animation_finished")
			$pig_contributor/cutout_character/animator.play("coding")
		4:
			yield($dialogue/control/dialogue_box/button, "button_up")
			$pig_contributor/timer.start()
			$juan.set_process_input(true)
			get_tree().set_pause(false)
