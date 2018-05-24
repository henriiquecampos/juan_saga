extends "res://levels/level_00/level_00.gd"

func _ready():
	$pig_contributor/timer.start()
	$pig_contributor/cutout_character/animator.play("coding")