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
				return "Hello 45301, How are you?"
			else:
				return "Hola 45301, ¿Cómo te va?"
		2:
			if lang == "en":
				return "I accidentally called you on your corporate number \n yesterday. Sorry, I know your name is #)'$%/?"
			else:
				return "Ayer te llamé por tu número corporativo sin darme \n cuenta. Lo siento, sé que te llamas #)'$%/?"
		3:
			if lang == "en":
				return "A woman who is treated like an \n object at work. That's regrettable. And we \n won't do anything; everything will \n continue like this."
			else:
				return "Una mujer que es tratada \n como un objeto en el trabajo. Eso es \n lamentable. Y no haremos \n nada; todo seguirá así."
		4:
			if lang == "en":
				return "Pss... That poor guy is said to be in huge debts \n and never makes his monthly bonus. Why \n doesn't he just get something better?"
			else:
				return "Pss... Se dice que ese pobre tipo tiene grandes deudas \n y nunca alcanza el bono mensual. ¿Por qué no \n simplemente consigue algo mejor?"
		5:
			if lang == "en":
				return "Have you seen that vacation sign? \n It was actually there when I \n arrived here four years ago."
			else:
				return "¿Has visto ese cartel de vacaciones? \n En realidad cuando llegué aquí hace \n cuatro años ya estaba."
		6:
			if lang == "en":
				return "I can see the tiredness on \n your face, and the determination in \n your soul, #)'$%/?"
			else:
				return "Puedo ver el cansacio en tu \n cara, y la decisión en tu alma, #)'$%/?"
		7:
			if lang == "en":
				return "*Unintelligible* I think \n I should wake up too..."
			else:
				return "*Inentendible* Creo que \n también debería despertar..."
