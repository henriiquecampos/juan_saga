extends "res://screens/basic_screen.gd"

const BGM_MUSIC = preload("res://screens/credit_screen/ending_music.ogg")
func _ready():
	bgm.get_node("animator").play_backwards("fade")
	yield(bgm.get_node("animator"), "animation_finished")
	bgm.stream = BGM_MUSIC
	bgm.play()
	bgm.get_node("animator").play("fade")
	$back.grab_focus()
	
func _process(delta):
	$"credits_viewport/parallax_background/parallax_layer".motion_offset.y -= 30 * delta