extends Area2D

func _on_area_entered(area):
	if area.is_in_group("pickup"):
		print("picked")
		area.queue_free()
		
func _input(event):
	if event.is_action_pressed("right"):
		$neck_left.disabled = true
		$head_left.disabled = true
		$neck_right.disabled = false
		$head_right.disabled = false
	elif event.is_action_pressed("left"):
		$neck_right.disabled = true
		$head_right.disabled = true
		$neck_left.disabled = false
		$head_left.disabled = false