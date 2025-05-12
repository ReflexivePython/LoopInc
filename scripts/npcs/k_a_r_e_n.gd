extends Area2D

var body_inside = false
var interacted = false
@onready var bubble = $Label
@onready var interact = $interact

var lang = Config.current_language

#SFX
@onready var sfx = $Robot

func _ready() -> void:
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
		await get_tree().create_timer(12).timeout
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
	match Day.day:
		1:
			if lang == "en":
				return "Greetings. I'm K.A.R.E.N. LoopCorps' \n first automated worker. Enough \n with the niceties, go away."
			else:
				return "Saludos. Soy K.A.R.E.N. El primer \n trabajador autómata de LoopCorps. Basta \n de amabilidades, vete."
		2:
			if lang == "en":
				return "Do you want me to tell the boss you're \n being *UNPRODUCTIVE* by coming here?"
			else:
				return "¿Quieres que le cuente al jefe que \n estás siendo *IMPRODUCTIVO* al venir aquí?"
		3:
			if lang == "en":
				return "*zzzzzip* That guy is always late, I'll \n have to notify him with automated resources."
			else:
				return "*zzzzzip* Ese tipo siempre llega tarde, \n tendré que notificarlo con recursos autómatas."
		4:
			if lang == "en":
				return "If I don't tell you, no one else will: \n You and your performance are *PATHETIC*"
			else:
				return "Si no te lo digo yo, nadie más lo hará: \n Tú y tu desempeño son *PATÉTICOS*"
		5:
			if lang == "en":
				return "That intern was useless. I do \n daily what she did in a week. *bzz*"
			else:
				return "Esa pasante era inútil. Yo hago diariamente \n lo que ella hacía en una semana *bzz*"
		6:
			if lang == "en":
				return "I detect high levels of cortisol... \n How weak you are."
			else:
				return "Detecto niveles altos de cortisol... \n Qué débil eres."
		7:
			if lang == "en":
				return "SYS64: Worker not found in database."
			else:
				return "*SYS64: Trabajador no encontrado en la base de datos."
