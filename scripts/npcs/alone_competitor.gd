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
				return "I don't have time to talk now. \n I have to submit this report before 12 p.m."
			else:
				return "Ahora no tengo tiempo para hablar.\n Debo entregar este informe antes de las 12 p.m."
		2:
			if lang == "en":
				return "Let me work. That monthly bonus \n won't come by itself."
			else:
				return "Déjame trabajar. Ese \n bono mensual no llegará solo."
		3:
			if lang == "en":
				return "Damn! That stupid old man \n has the advantage again."
			else:
				return "¡Maldita sea! Ese estúpido anciano \n de nuevo tiene la ventaja"
		4:
			if lang == "en":
				return "*sigh* The boss has his \n preferences, of course..."
			else:
				return "*suspiro* El jefe tiene sus \n preferencias, desde luego..."
		5:
			if lang == "en":
				return "Go away, I'm not in the mood \n to talk. That old man keeps rubbing \n his 'victory' in my face."
			else:
				return "Vete, no estoy de humor para hablar. \n Ese anciano no para de restregarme su \n 'victoria' en mi cara."
		6:
			if lang == "en":
				return "*deep sigh* What will I \n tell my wife this month?"
			else:
				return "*suspiro hondo* ¿Qué le \n diré a mi esposa este mes?"
		7:
			if lang == "en":
				return "Huh? I swear I saw that guy... \n Never mind, back to work."
			else:
				return "¿Eh? Juraría haber visto a ese tipo... \n No importa, a trabajar."
