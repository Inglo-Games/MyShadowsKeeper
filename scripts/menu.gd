extends Node2D

func _on_start_pressed():
	get_tree().change_scene("res://scenes/level01.tscn")

func _on_tut_pressed():
	get_tree().change_scene("res://scenes/tutorial.tscn")

func _on_quit_pressed():
	get_tree().quit()
