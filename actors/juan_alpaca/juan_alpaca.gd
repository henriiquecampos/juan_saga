extends "res://actors/platform_actors/player_platform_character.gd"

onready var initial_speed = walk_speed
onready var animator = $cutout_character/animator
onready var fighter = $player_fighter
func _on_state_changed(from, to):
	match to:
		states.WALK:
			animator.play("walk")
			fighter.set_state(fighter.states.STAND)
		states.IDLE:
			animator.play("idle")
			fighter.set_state(fighter.states.STAND)
		states.FALL:
			animator.play("fall")
			fighter.set_state(fighter.states.IN_AIR)
		states.JUMP:
			fighter.set_state(fighter.states.IN_AIR)
			animator.play("jump")
			$sfx.play()

func _on_bugs_new_child(penalty, child_amount):
	walk_speed -= penalty
	jump_height -= penalty
	$debug.visible = child_amount > 1

func _on_fighter_area_shape_entered(area_id, area, area_shape, self_shape):
	match self_shape:
		fighter.states.IDLE:
			var n = (fighter.get_child(self_shape).global_position - area.get_child(area_shape).global_position).normalized()
			n = floor(n.y)
			if n >= 0 or state != states.FALL:
				return
			if area.has_method("damage_parent"):
				area.damage_parent(5)
				set_state(states.JUMP)
				velocity.y = -jump_height * 0.8

func _input(event):
	if event.is_action_pressed("debug"):
		match state:
			states.IDLE:
				if $bugs.bugs_count() <= 0:
					return
				$bugs.damage_child()
				$cutout_character/animator_01.play("shake")