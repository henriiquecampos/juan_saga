extends "res://levels/level_00.gd"

func _on_dialogue_changed(to):
	match to:
		0:
			var pos = $computer.global_position
			pos.y -= 200
			$camera.tween_position(pos)
		1:
			$camera.tween_position($rocket/center.global_position)
