extends "res://actors/enemies/ground_bug.gd"

func _spawn_minions():
	for i in bugs_spawn:
		var s = SCREEN_BUG.instance()
		s.position.x = rand_range(-64, 64)
		s.position.y = rand_range(-64, 64)
		$bugs.add_child(s)


func _remove_minions():
	for c in $bugs.get_children():
		c.queue_free()
