extends Node2D
export (int) var health = 3 setget set_health
export (int) var damage = 5
export (int) var penalty = 5
export (int) var score = 15
const SCORE_POP = preload("res://interface/score_pop.tscn")
func _ready():
	get_parent().emit_signal("new_child", penalty, get_parent().get_child_count())
	$timer.set_wait_time(rand_range(0.5, 2))
	connect("tree_exited", get_parent(), "_on_screen_bug_tree_exited", [self])
	$timer.connect("timeout", get_parent(), "_on_screen_bug_timeout", [self])
	$timer.connect("timeout", $animator, "play", ["damage"])

func set_health(value):
	health = value
	if health < 1:
		var s = SCORE_POP.instance()
		s.position = position
		s.get_node("label").text = s.get_node("label").text.format({"score":int(score)})
		get_parent().add_child(s)
		get_parent().get_node("sfx").position = position
		var p = load("res://actors/enemies/particles/bug_death.tscn").instance()
		p.position = position
		get_parent().add_child(p)
		p.emitting = true
		queue_free()

func damage_health(amount):
	set_health(health - amount)
	$animator.play("hurt")
	yield($animator, "animation_finished")
	$animator.play("idle")

func _on_timer_timeout():
	var c = Color("f95555")
	var s = SCORE_POP.instance()
	s.position = position
	s.scale = Vector2(0.5,0.5)
	s.modulate = c
	s.get_node("label").text = s.get_node("label").text.format({"score":int(-damage)})
	get_parent().add_child(s)
