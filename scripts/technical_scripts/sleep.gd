extends Area2D

var body_inside = false
@onready var interact = $interact
@onready var warn_text = $warn
var message = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' to go sleep"
		warn_text.text = "You must go work first"
	else:
		interact.text = "Pulsa 'E' para ir \n a dormir"
		warn_text.text = "Primero debes ir a trabajar"


func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func _input(_event: InputEvent) -> void:
	var entered = body_inside == true
	var pressed = Input.is_action_just_pressed("E")
	
	if pressed and entered and Day.daily_objective <= 0:
		Day.day_finished = true
		Day.advance_day()
		Save.save_game()
		get_tree().change_scene_to_file("res://scenes/day_transition.tscn")
	
	elif pressed and entered and Day.day_finished == true:
		Day.advance_day()
		Save.save_game()
		get_tree().change_scene_to_file("res://scenes/day_transition.tscn")
		
	elif pressed and entered and Day.day_finished == false:
		show_warn()
		

func show_warn():
	if message == true:
		return
	
	message = true
	warn_text.visible = true
	await get_tree().create_timer(3).timeout
	warn_text.visible = false
	message = false
