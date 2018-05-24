extends Position2D

export (float) var min_time = 3.0
export (float) var max_time = 8.0
export (Animation) var anim
export (bool) var can_spawn = true

const BUG = preload("res://actors/enemies/ground_bug.tscn")

func _ready():
	$animator.add_animation("idle", anim)
	$animator.play("idle")
	randomize()
	$timer.set_wait_time(rand_range(min_time, max_time))
	$timer.connect("timeout", self, "_on_timer_timeout")
	$timer.start()
	
func _on_timer_timeout():
	if !can_spawn:
		return
	_spawn()

func _spawn():
	var s = BUG.instance()
	s.global_position = global_position
	$"../bugs".add_child(s)
	$timer.set_wait_time(rand_range(min_time, max_time))
	$timer.start()