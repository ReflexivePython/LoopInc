extends Area2D

var body_inside = false
var interacted = false
@onready var bubble = $Label
@onready var interact = $interact

var lang = Config.current_language

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' \n to inspect"
	else:
		interact.text = "Pulsa 'E' \n para revisar"

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and body_inside == true and interacted == false:
		interacted = true
		bubble.visible = true
		show_text_typing(day_text())
		await get_tree().create_timer(12).timeout
		bubble.visible = false
		interacted = false

func show_text_typing(text: String, delay := 0.05) -> void:
	bubble.text = ""
	for i in text.length():
		bubble.text += text[i]
		await get_tree().create_timer(delay).timeout
		bubble.size = bubble.get_minimum_size()
		bubble.size = bubble.size + Vector2(20, 20)

func day_text():
	match Day.day:
		1,2,3,4:
			if lang == "en":
				return "It's too dirty, you can't \n look at yourself."
			else:
				return "Está demasiado sucio, \n no te puedes mirar."
		5,6:
			if lang == "en":
				return "It's too dark, you \n can't see anything."
			else:
				return "Está demasiado oscuro, \n no ves nada."
		7:
			if lang == "en":
				return "Now you have no excuses \n to see clearly."
			else:
				return "Ahora no tienes excusas \n para ver con claridad."
