extends Area2D
const BUG = preload("res://actors/enemies/screen_bug.tscn")

var can_interact = false
export (bool) var can_bug = true
var dev_speed = 100
export (NodePath) var icons_path
onready var icons_node = get_node(icons_path)

func _process(delta):
	if can_interact:
		if Input.is_action_pressed("interact"):
			if $bugs.get_child_count() == 0:
				$debug.hide()
			$progress_bar.value += dev_speed * delta
		if Input.is_action_just_released("interact"):
			$progress_bar.value = 0
		if Input.is_action_just_pressed("debug"):
			$bugs.damage_child()
			

func _on_area_entered(area):
	if area.is_in_group("player"):
		can_interact = true
		$progress_bar.value = 0
		$progress_bar.show()

func _on_area_exited(area):
	if area.is_in_group("player"):
		can_interact = false
		$progress_bar.value = 0
		$progress_bar.hide()
		$debug.hide()

func _on_progress_bar_value_changed(value):
	if value >= 100:
		bump()
		$progress_bar.value = 0
		if !can_bug:
			return
		var bug_amount = randi()%3
		for i in bug_amount:
			add_bug()

func screen_bug():
	$progress_bar.value -= 10
	
func add_bug():
	var s = BUG.instance()
	s.position.x = rand_range(16, 200)
	s.position.y = rand_range(16, 120)
	s.get_node("timer").connect("timeout", self, "screen_bug")
	$bugs.add_child(s)
	
func bump():
	if icons_node.get_child_count() >= 5:
		return
	icons_node.juan_new_node()
	$sfx.play()
	var initial_scale = $sprite.scale
	$tween.interpolate_property($sprite, "scale", initial_scale, initial_scale * 1.05, 0.25,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	$tween.interpolate_property($sprite, "scale", $sprite.scale, initial_scale, 0.25,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	$sprite.rotation_degrees = 0

func _on_bugs_new_child(penalty, child_amount):
	dev_speed -= penalty
	$debug.visible = child_amount > 1