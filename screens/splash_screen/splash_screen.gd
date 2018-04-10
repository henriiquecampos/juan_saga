extends "res://screens/basic_screen.gd"


func _on_animator_animation_finished(anim_name):
	if anim_name == "fade":
		$animator.play("pigdev_splash")
		yield($animator, "animation_finished")
		change_scene()
