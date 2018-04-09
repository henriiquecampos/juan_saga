extends "res://screens/basic_screen.gd"

func _ready():
	var bgm = AudioServer.get_bus_index("bgm")
	$bgm_volume.value = AudioServer.get_bus_volume_db(bgm)
	var sfx = AudioServer.get_bus_index("sfx")
	$sfx_volume.value = AudioServer.get_bus_volume_db(sfx)
	
func _on_bgm_volume_value_changed(value):
	var bgm = AudioServer.get_bus_index("bgm")
	AudioServer.set_bus_volume_db(bgm, value)

func _on_sfx_volume_value_changed(value):
	$sfx_volume/sfx_test.play()
	var sfx = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(sfx, value)
