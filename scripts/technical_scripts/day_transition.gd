extends Control

@onready var label = $Label
@onready var day = $day
@onready var last_day = $last_day
@onready var animation = $AnimationPlayer
@onready var saved = $saved_state

func _ready() -> void:
	if Config.current_language == "en":
		label.text = "Day"
		saved.text = "Progress saved..."
	else:
		label.text = "Día"
		saved.text = "Progreso guardado..."
	
	day.text = str(Day.day)
	last_day.text = str(Day.day - 1)
	animation.play("day_transition")
	
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://scenes/room.tscn")
