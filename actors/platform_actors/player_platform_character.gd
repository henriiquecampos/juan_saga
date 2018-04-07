extends "res://actors/platform_actors/platform_character.gd"

func _input(event):
	if event.is_action_pressed("jump"):
		set_state(JUMP)
	elif event.is_action_released("jump"):
		match state:
			JUMP:
				cancel_jump()
				
	if event.is_action_pressed("right"):
		direction = 1
		match state:
			IDLE:
				set_state(WALK)
			JUMP:
				velocity.x = direction * in_jump_speed
	elif event.is_action_released("right"):
		match state:
			WALK:
				set_state(IDLE)
	if event.is_action_pressed("left"):
		direction = -1
		match state:
			IDLE:
				set_state(WALK)
			JUMP:
				velocity.x = direction * in_jump_speed
	elif event.is_action_released("left"):
		match state:
			WALK:
				set_state(IDLE)