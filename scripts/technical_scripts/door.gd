extends Area2D

var body_inside = false
var triggered = false

@onready var interact = $interact
@onready var door_sfx = $DoorSfx
@onready var door_locked = $DoorLocked

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Day.day_finished:
		change_text()
	else:
		set_text()

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func set_text():
	if Config.current_language == "en":
		interact.text = "Press 'E' to go work"
	else:
		interact.text = "Pulsa 'E' para ir \n al trabajo"

func change_text():
	if Config.current_language == "en":
		interact.text = "You finished your shift"
	else:
		interact.text = "Terminaste tu turno"


func _input(_event: InputEvent) -> void:
	var pressed = Input.is_action_just_pressed("E")
	var entered = body_inside == true
	var day_finished = Day.day_finished == true
	
	if  pressed and entered and Day.daily_objective <= 0:
		Day.day_finished = true
		
	elif pressed and entered and day_finished:
		door_locked.play()
		return
	elif pressed and entered and not triggered:
		triggered = true
		door_sfx.play()
		await door_sfx.finished
		get_tree().change_scene_to_file("res://scenes/main.tscn")
