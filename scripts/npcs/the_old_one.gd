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
				return "Good Morning! I hope \n you'll have a productive day!"
			else:
				return "¡Buenos días! ¡Espero tengas \n un día productivo!"
		2:
			if lang == "en":
				return "Ain't nothing better than my coffee cup! \n Did you know it was a gift from the boss?"
			else:
				return "¡No hay nada mejor que mi taza de café! \n ¿Sabías que fue un regalo del jefe?"
		3:
			if lang == "en":
				return "I've been with this company \n for 28 years, and things just \n keep getting better!"
			else:
				return "He estado en esta compañía \n por 28 años, ¡y las cosas \n cada vez se ponen mejores!"
		4:
			if lang == "en":
				return "Why do you have those dark  \n circles, boy? Cheer up,  \n it's almost weekend!"
			else:
				return "¿Por qué tienes esas ojeras, \n muchacho? Anímate, ¡que ya \n casi es fin de semana!"
		5:
			if lang == "en":
				return "You know, I haven't seen the \n intern for a few days, she was a \n beautiful woman, it's a shame \n she's gone."
			else:
				return "Sabes, no he visto a la \n pasante desde hace algunos días, \n ella era una mujer hermosa, \n es una lástima que  \n se ha ido."
		6:
			if lang == "en":
				return "It's finally weekend. What \n are you planning on doing, kid? \n Maybe go out with some girls?"
			else:
				return "Finalmente es fin de \n semana. ¿Qué planeas hacer, \n muchacho? ¿Quizá ir con \n algunas chicas?"
		7:
			if lang == "en":
				return "I swear I saw someone pass by"
			else:
				return "Juraría que ví pasar a alguien"
