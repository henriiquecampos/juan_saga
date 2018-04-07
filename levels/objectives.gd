extends Node2D

onready var amount = get_child_count() setget set_amount
var completed = false

func set_amount(value):
	amount = get_child_count()
	if amount == 0:
		emit_signal("completed")
		completed = true