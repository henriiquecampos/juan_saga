extends "res://actors/platform_actors/platform_character.gd"

func _input(event):
	match state:
		IDLE:
			if event.is_action_pressed("right") :
				direction = 1
				set_state(WALK)
			elif event.is_action_pressed("left") :
				direction = -1
				set_state(WALK)
			if event.is_action_pressed("jump"):
				set_state(JUMP)
				
		WALK:
			if event.is_action_pressed("right") :
				direction = 1
			elif event.is_action_pressed("left") :
				direction = -1
			elif event.is_action_released("right") and direction == 1:
				set_state(IDLE)
			elif event.is_action_released("left") and direction == -1:
				set_state(IDLE)
			if event.is_action_pressed("jump"):
				set_state(JUMP)

		JUMP:
			if event.is_action_pressed("right") :
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left") :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right") and direction == 1:
				velocity = stop()
			elif event.is_action_released("left") and direction == -1:
				velocity = stop()
			if event.is_action_released("jump"):
				cancel_jump()
		FALL:
			if event.is_action_pressed("right") :
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left") :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right") and direction == 1:
				velocity = stop()
			elif event.is_action_released("left") and direction == -1:
				velocity = stop()