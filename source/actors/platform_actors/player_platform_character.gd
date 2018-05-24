extends "res://actors/platform_actors/platform_character.gd"

export (String) var player = "_1"

func _ready():
	if player == null:
		player = "_1"
func _input(event):
	match state:
		IDLE:
			if event.is_action_pressed("right" + player) :
				direction = 1
				set_state(WALK)
			elif event.is_action_pressed("left"+ player) :
				direction = -1
				set_state(WALK)
			if event.is_action_pressed("jump"+ player):
				set_state(JUMP)
				
		WALK:
			if event.is_action_pressed("right"+ player) :
				direction = 1
			elif event.is_action_pressed("left"+ player) :
				direction = -1
			elif event.is_action_released("right"+ player) and direction == 1:
				set_state(IDLE)
			elif event.is_action_released("left"+ player) and direction == -1:
				set_state(IDLE)
			if event.is_action_pressed("jump"+ player):
				set_state(JUMP)

		JUMP:
			if event.is_action_pressed("right"+ player) :
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left"+ player) :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right"+ player) and direction == 1:
				velocity = stop()
			elif event.is_action_released("left"+ player) and direction == -1:
				velocity = stop()
			if event.is_action_released("jump"+ player):
				cancel_jump()
		FALL:
			if event.is_action_pressed("right"+ player) :
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left"+ player) :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right"+ player) and direction == 1:
				velocity = stop()
			elif event.is_action_released("left"+ player) and direction == -1:
				velocity = stop()