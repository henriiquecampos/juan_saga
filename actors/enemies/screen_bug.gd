extends Node2D
var health = 3 setget set_health
func _ready():
	$button.connect("button_up", self, "set_health", [-1])
	$timer.set_wait_time(rand_range(0.5, 2))

func set_health(value):
	if health > 0:
		health += value
	else:
		queue_free()