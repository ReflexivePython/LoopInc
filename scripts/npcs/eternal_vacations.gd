extends Area2D

var body_inside = false
var interacted = false
@onready var bubble = $Label
@onready var npc = $AnimatedSprite2D
@onready var interact = $interact

var lang = Config.current_language

#SFX
@onready var sfx = $Pop

func _ready() -> void:
	npc.play("default")
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' \n to interact"
	else:
		interact.text = "Pulsa 'E' \n para interactuar"

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
		await get_tree().create_timer(10).timeout
		bubble.visible = false
		interacted = false

func show_text_typing(text: String, delay := 0.05) -> void:
	bubble.text = ""
	for i in text.length():
		bubble.text += text[i]
		sfx.play()
		await get_tree().create_timer(delay).timeout
		bubble.size = bubble.get_minimum_size()
		bubble.size = bubble.size + Vector2(20, 20)

func day_text():
	var current_date = Time.get_date_dict_from_system()
	var vacation_date = {
		"year" : 2035,
		"month" : 4,
		"day" : 8
	}
	
	if current_date["year"] >= vacation_date["year"] && \
	current_date["month"] >= vacation_date["month"] && \
	current_date["day"] >= vacation_date["day"]:
		if lang == "en":
			return "Really? Did you just changed the \n date on your device? \n Well, this guy is on vacation until eternity."
		else:
			return "¿Enserio? ¿Cambiaste la fecha de tu equipo? \n Bueno, este tipo está en vacaciones hasta la eternidad."
	else:
		match Day.day:
			1,2,3,4,5:
				if lang == "en":
					return "The note says: \n 'On vacations until \n April 8th, 2035'"
				else:
					return "La nota dice: \n 'En vacaciones hasta el \n 8 de Abril del 2035'"
			6,7:
				if lang == "en":
					return "The text seems to be \n different this time: \n 'I see the confidence on you'"
				else:
					return "El texto parece ser \n diferente esta vez: \n 'Veo la confianza en tí'"

	
