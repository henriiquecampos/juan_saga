extends "res://screens/basic_screen.gd"

func _ready():
	set_instructions($"colums/juan/row/label", "left")
	set_instructions($"colums/juan/row/label", "right")
	set_instructions($"colums/juan/row/label", "jump")
	set_instructions($"colums/bug/row/label", "debug")
	set_instructions($"colums/computer/row/label", "interact")
	set_instructions($"colums/rocket/row/label", "interact")
	
func set_instructions(label, action):
	var t = label.text
	var i = InputMap.get_action_list(action)[0].as_text()
	label.text = t.format({action:"%s key"%i})