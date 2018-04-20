extends "res://actors/platform_actors/platform_character.gd"

export(int) var health = 3 setget set_health
export(int) var bugs_spawn = 1
export(int) var score = 15
export(int) var jumps = 5
export(int) var penalty = 5
var player = null
const SCREEN_BUG = preload("res://actors/enemies/screen_bug.tscn")
const SCORE_POP = preload("res://interface/score_pop.tscn")

signal health_changed(from, to)

func _on_area_entered(area):
	if area.is_in_group("player"):
		player = area
		jumps = 5
		velocity.x = walk_speed * (player.global_position - global_position).normalized().x
		set_state(JUMP)
		$sfx.play()
		$jump_interval.start()

func _on_attach_area_entered(area):
	if area.is_in_group("player"):
		for i in bugs_spawn:
			var s = SCREEN_BUG.instance()
			s.position.x = rand_range(-16, 16)
			s.position.y = rand_range(-16, 16)
			area.get_node("../bugs").add_child(s)
		queue_free()
		
func set_health(value):
	emit_signal("health_changed", health, value)
	health = value
	if health < 1:
		var s = SCORE_POP.instance()
		s.global_position = global_position
		s.get_node("label").text = s.get_node("label").text.format({"score":int(score)})
		get_parent().add_child(s)
		get_parent()._on_screen_bug_tree_exited(self)
		get_parent().get_node("sfx").position = position
		queue_free()

func damage_health(amount):
	set_health(health - amount)

func _on_jump_interval_timeout():
	if player == null or jumps < 1:
		return
	velocity.x = walk_speed * (player.global_position - global_position).normalized().x
	set_state(JUMP)
	$sfx.play()
	jumps -= 1

func _on_range_area_exited(area):
	if area.is_in_group("player"):
		
		$jump_interval.stop()
