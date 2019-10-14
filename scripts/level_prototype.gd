extends Node2D
class_name Level

# Intro slide text
export var text_top = ""
export var text_bottom = ""

onready var intro_color : ColorRect = $transition/color
onready var intro_label_top : Label = $transition/label_top
onready var intro_label_bottom : Label = $transition/label_bottom
onready var tween : Tween = $tween

var start_pos = Vector2()

func _ready():
	
	start_pos = $character.position
	
	intro_text()
	
	for child in $flames_group.get_children():
		child.connect("body_entered", self, "reset_character")
	
	$goal.connect("body_entered", self, "goto_next_level")
	$bottom.connect("body_entered", self, "reset_character")

func intro_text():
	
	# Setup text and visibility
	intro_color.visible = true
	intro_color.modulate = Color(1, 1, 1, 1)
	intro_label_top.text = text_top
	intro_label_top.visible = true
	intro_label_top.modulate = Color(1, 1, 1, 0)
	intro_label_bottom.text = text_bottom
	intro_label_bottom.visible = true
	intro_label_bottom.modulate = Color(1, 1, 1, 0)
	
	# Fade top text in
	tween.interpolate_property(intro_label_top, "modulate:a", 0, 1, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.remove_all()
	yield(get_tree().create_timer(0.6), "timeout")
	
	# Fade bottom text in
	tween.interpolate_property(intro_label_bottom, "modulate:a", 0, 1, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	tween.remove_all()
	yield(get_tree().create_timer(2.0), "timeout")
	
	# Fade everything out
	tween.interpolate_property(intro_color, "modulate:a", 1, 0, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.interpolate_property(intro_label_top, "modulate:a", 1, 0, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.interpolate_property(intro_label_bottom, "modulate:a", 1, 0, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")

func goto_next_level(body):
	
	$goal.queue_free()
	
	# Fade everything out
	tween.interpolate_property(intro_color, "modulate:a", 0, 1, 1.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")

func reset_character(body):
	
	if body is Player:
		
		tween.interpolate_property(intro_color, "modulate:a", 0, 1, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_all_completed")
		
		body.position = start_pos
		
		tween.interpolate_property(intro_color, "modulate:a", 1, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_all_completed")
