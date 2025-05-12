extends Node

var current_language : String = "en"
var movement_type : String = "WASD"
var is_android = false
var muted: bool = false

func _ready() -> void:
	check_if_android()

func check_if_android():
	if OS.get_name() == "Android":
		is_android = true

func set_mute():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),muted)
