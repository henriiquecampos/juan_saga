extends Node2D

var speed = 200
export (NodePath) var icons_path
onready var icons_node = get_node(icons_path)
export (NodePath) var score_path
onready var score_node = get_node(score_path)
var can_interact = false
var min_score = 0 setget set_minimum_score
const SCORE_POP = preload("res://interface/score_pop.tscn")

func _ready():
	set_physics_process(false)
	
func _process(delta):
	if get_tree().is_paused():
		return
	if can_interact:
		if Input.is_action_pressed("interact"):
			$progress_bar.value += 100 * delta
		if Input.is_action_just_released("interact"):
			$progress_bar.value = 0

func _physics_process(delta):
	move_local_y(-speed * delta)
	speed += 200 * delta

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

func _on_progress_bar_value_changed(value):
	if value >= 100:
		if icons_node.get_child_count() > 0:
			icons_node.get_child(icons_node.get_child_count() -1).queue_free()
			score_node.score += value
			bump_rocket()
			pop_score(value)
		if icons_node.get_child_count() > 1:
			$progress_bar.value = 0

func bump_rocket():
	var initial_scale = $sprite.scale
	$sfx.stream = load("res://objects/rocket/5_scoring.ogg")
	$sfx.play()
	$tween.interpolate_property($sprite, "scale", initial_scale, initial_scale * 1.05, 0.25,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$animator.play("shake")
	$tween.start()
	yield($tween, "tween_completed")
	$tween.interpolate_property($sprite, "scale", $sprite.scale, initial_scale, 0.25,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	$animator.stop()
	$sprite.rotation_degrees = 0
	
func launch():
	$sprite/label.hide()
	$sprite/ramp.hide()
	$progress_bar.hide()
	$sfx.stream = load("res://objects/rocket/7_charging.ogg")
	$sfx.play()
	$sprite.texture = load("res://objects/rocket/sprite_closed.png")
	$animator.play("shake")
	$particles.emitting = true
	$timer.start()
	yield($timer, "timeout")
	$animator.stop()
	$particles.amount = 36
	$particles.lifetime = 4
	$particles.speed_scale = 2
	$timer.start()
	$sfx.stream = load("res://objects/rocket/6_launching.ogg")
	$sfx.play()
	$sprite.rotation_degrees = 0
	set_physics_process(true)
	yield($timer, "timeout")
	queue_free()
	
func set_minimum_score(value):
	min_score = value
	var t = "{amount}"
	$sprite/label.text = t.format({"amount":int(min_score)})
	
func update_score(current_score):
	var d = clamp(min_score - current_score, 0, min_score)
	var t = "{amount}"
	$sprite/label.text = t.format({"amount":int(d)})
	
func pop_score(amount):
	var s = SCORE_POP.instance()
	s.position.y -= 100
	s.get_node("label").text = s.get_node("label").text.format({"score":int(amount)})
	add_child(s)