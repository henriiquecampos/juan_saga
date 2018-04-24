extends Node2D
export (PoolStringArray) var dialogues
export (NodePath) var fade_animator_path
onready var fade_animator = get_node(fade_animator_path)
var _index = 0
signal dialogue_changed(to)
func _ready():
	$label.text = dialogues[_index]
	pop_dialogue()
	yield($tween, "tween_completed")
	display_text()
	
func pop_dialogue():
	$tween.interpolate_property(self, "scale", Vector2(0,0), Vector2(1,1),
		1.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	fade_animator.play("fade")
	$button.grab_focus()
	get_tree().set_pause(true)
	
func display_text():
	emit_signal("dialogue_changed", _index)
	$button.text = "skip"
	$tween.interpolate_property($label, "percent_visible", 0.0, 1.0, 
		2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$tween.start()
	yield($tween, "tween_completed")
	$button.text = "next"

func finish_dialogue():
	$tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(0,0),
		0.5, Tween.TRANS_BACK, Tween.EASE_IN)
	$tween.start()
	yield($tween, "tween_completed")
	fade_animator.play_backwards("release")
	get_tree().set_pause(false)
	$button.release_focus()
	queue_free()

func _on_button_up():
	if $label.percent_visible < 1.0 and $tween.is_active():
		$label.percent_visible = 1.0
		$tween.stop($label, "percent_visible")
		$button.text = "next"
	else:
		if _index < dialogues.size() -1:
			_index += 1
			$label.text = dialogues[_index]
			display_text()
		else:
			finish_dialogue()