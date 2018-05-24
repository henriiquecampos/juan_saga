extends "platform_actor.gd"

export (String) var left = "left_1"
export (String) var right = "right_1"
export (String) var jump = "jump_1"
export (String) var interact = "interact_1"
export (String) var debug = "debug_1"
func handle_input():
	pass
func _input(event):
	state_machine.state.handle_input(self, event)