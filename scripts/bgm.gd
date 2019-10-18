extends Node

onready var bgm_player : AudioStreamPlayer = AudioStreamPlayer.new()
onready var stream : AudioStreamOGGVorbis = preload("res://assets/Reflections.ogg")

func _ready():
	stream.loop = true
	bgm_player.set_stream(stream)
	get_tree().get_root().call_deferred("add_child", bgm_player)
	bgm_player.play()
