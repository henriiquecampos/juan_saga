extends "res://levels/level_00/level_00.gd"

func _ready():
	$screen/game_screen/animator.connect("animation_finished", self, "_on_game_screen_animation_finished")

func _on_dialogue_changed(to):
	match to:
		0:
			get_tree().set_pause(true)
		3:
			$camera.tween_position($computer.global_position + Vector2(50, -200))
			yield($dialogue/control/dialogue_box/button, "button_up")
			$computer.add_bug()
		4:
			yield($dialogue/control/dialogue_box/button, "button_up")
			get_tree().set_pause(false)

func _on_game_screen_animation_finished(anim_name):
	if anim_name == "fade":
		$dialogue/control/dialogue_box.show()
		$dialogue/control/dialogue_box.pop_dialogue()
		yield($dialogue/control/dialogue_box/tween, "tween_completed")
		$dialogue/control/dialogue_box.display_text()
		$screen/game_screen/animator.disconnect("animation_finished", self, "_on_game_screen_animation_finished")