extends "res://actors/platform_actors/platform_character.gd"

export(int) var health = 3 setget set_health
export(int) var bugs_spawn = 1
export(int) var score = 15
const SCREEN_BUG = preload("res://actors/enemies/screen_bug.tscn")

func _ready():
	$button.connect("button_up", self, "damage_health", [1])
	
func _on_area_entered(area):
	if area.is_in_group("player"):
		velocity.x = walk_speed * (area.global_position - global_position).normalized().x
		set_state(JUMP)
		$sfx.play()

func _on_attach_area_entered(area):
	if area.is_in_group("player"):
		for i in bugs_spawn:
			var s = SCREEN_BUG.instance()
			s.position.x = rand_range(-16, 16)
			s.position.y = rand_range(-16, 16)
			area.get_node("../bugs").add_child(s)
		queue_free()
		
func set_health(value):
	health = value
	if health < 1:
		get_parent()._on_screen_bug_tree_exited(self)
		get_parent().get_node("sfx").position = position
		queue_free()

func damage_health(amount):
	set_health(health - amount)