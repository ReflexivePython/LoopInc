extends Area2D


@onready var interact = $interact
@onready var warn_text = $warn

@onready var door_sfx = $DoorSfx
@onready var door_locked = $DoorLocked

var body_inside = false
var message = false
var triggered = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' to go home"
		warn_text.text = "You think you can go home? \n Finish your tasks first!"
	else:
		interact.text = "Pulsa 'E' para ir \n a casa"
		warn_text.text = "¿Crees que puedes ir a casa? \n ¡Termina tus tareas primero!"

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func _input(_event: InputEvent) -> void:
	var pressed = Input.is_action_just_pressed("E")
	var entered = body_inside == true
	
	if pressed and entered and Day.daily_objective <= 0 and not triggered:
		triggered = true
		if Day.day == 4:
			door_sfx.play()
			await  door_sfx.finished
			Day.day_finished = true
			get_tree().change_scene_to_file("res://scenes/day_four.tscn")
		else:
			door_sfx.play()
			await door_sfx.finished
			Day.day_finished = true
			get_tree().change_scene_to_file("res://scenes/room.tscn")
		
	elif pressed and entered and Day.daily_objective > 0:
		if message == true:
			return
		show_warn()
	

func show_warn():
	message = true
	warn_text.visible = true
	door_locked.play()
	await get_tree().create_timer(3).timeout
	warn_text.visible = false
	message = false
