extends "res://actors/platform_actors/platform_character.gd"

func _input(event):
	match state:
		states.IDLE:
			if event.is_action_pressed("right") :
				direction = 1
				set_state(states.WALK)
			elif event.is_action_pressed("left") :
				direction = -1
				set_state(states.WALK)
			if event.is_action_pressed("jump"):
				set_state(states.JUMP)
				
		states.WALK:
			if event.is_action_pressed("right") :
				direction = 1
			elif event.is_action_pressed("left") :
				direction = -1
			elif event.is_action_released("right") and direction == 1:
				set_state(states.IDLE)
			elif event.is_action_released("left") and direction == -1:
				set_state(states.IDLE)
			if event.is_action_pressed("jump"):
				set_state(states.JUMP)

		states.JUMP:
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
		states.FALL:
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