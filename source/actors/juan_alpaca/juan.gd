extends "res://addons/platform_actors/player_platform_actor.gd"

onready var fighter = $player_fighter
func _on_character_perform_action(action):
	match action:
		"jump":
			if is_on_floor():
				$sfx.play()

func _on_bugs_new_child(penalty, child_amount):
	walk_speed -= penalty
	jump_height -= penalty
	$debug.visible = child_amount > 1

func _on_player_fighter_area_shape_entered(area_id, area, area_shape, self_shape):
	if !area.is_in_group("enemy"):
		return
	match self_shape:
		fighter.IDLE:
			var n = (fighter.get_child(self_shape).global_position - area.get_child(area_shape).global_position).normalized()
			n = floor(n.y)
			if n >= 0 or state_machine.state.name != "jump":
				return
			if area.has_method("damage_parent"):
				area.damage_parent(5)
				velocity.y = -jump_height * 0.8
				emit_signal("perform_action", "jump")
				$sfx.play()
				
func debug():
	if $bugs.bugs_count() <= 0:
		return
	$bugs.damage_child()
	$cutout_character/animator_01.play("shake")