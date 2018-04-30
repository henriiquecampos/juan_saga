tool
extends TileMap

func _process(delta):
	if Input.is_mouse_button_pressed(0):
		print("pressed")