extends "res://actors/enemies/ground_bug.gd"

func _spawn_minions(to = $bugs, where = position, amount = bugs_spawn):
	for i in amount:
		var s = load("res://actors/enemies/ground_bug.tscn").instance()
		s.player = get_tree().get_nodes_in_group("player")[0]
		s.get_node("jump_interval").start()
		s.position.x = where.x + rand_range(-64, 64)
		s.position.y = where.y + rand_range(-64, 64)
		to.add_child(s)

func _remove_minions():
	for c in $bugs.get_children():
		c.queue_free()

func _on_health_changed(from, to):
	if to == 0:
		_spawn_minions(get_parent(), global_position, 10)
	$sprite/cutout_character/damage.play("damage")

func _on_state_changed(from, to):
	match to:
		JUMP:
			$sprite/cutout_character/animator.play("jump")
		IDLE:
			$sprite/cutout_character/animator.play("idle")
		WALK:
			$sprite/cutout_character/animator.play("idle")