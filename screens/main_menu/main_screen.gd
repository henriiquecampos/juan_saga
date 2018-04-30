extends "res://screens/basic_screen.gd"
var can_play = false
const BGM_MUSIC = preload("res://screens/main_menu/main_menu_music.ogg")
func _ready():
	var bus = AudioServer.get_bus_index("bgm")
	$bgm_volume.value = AudioServer.get_bus_volume_db(bus)
	bus = AudioServer.get_bus_index("sfx")
	$sfx_volume.value = AudioServer.get_bus_volume_db(bus)
	if !bgm.stream == BGM_MUSIC:
		bgm.stream = BGM_MUSIC
	if !bgm.is_playing():
		bgm.play()
	
func _on_bgm_volume_value_changed(value):
	var bus = AudioServer.get_bus_index("bgm")
	AudioServer.set_bus_volume_db(bus, value)

func _on_sfx_volume_value_changed(value):
	var bus = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(bus, value)
	if !can_play:
		can_play = true
		return
	$sfx_volume/sfx_test.play()