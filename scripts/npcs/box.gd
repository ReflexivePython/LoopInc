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
		4:
			if lang == "en":
				return "The box has some of the intern's things \n inside, including a broken mug that says: \n 'I could love this place'"
			else:
				return "La caja tiene algunas cosas de la pasante \n adentro, entre ellas, una taza rota que  \n dice: 'Podría amar este lugar'"
		5:
			if lang == "en":
				return "Why do you keep coming back? There's \n nothing else to see here."
			else:
				return "¿Por qué sigues viniendo? Ya no \n hay nada más por ver aquí."
		6:
			if lang == "en":
				return "Even though I told you there was \n nothing, you still insist on coming. \n Come back tomorrow."
			else:
				return "Incluso cuando te dije que no \n había nada sigues insistiendo \n en venir. Vuelve mañana."
		7:
			if lang == "en":
				return "*hisses* Thanks for coming, this might \n be the last time we see each other here."
			else:
				return "*siseos* Gracias por venir, quizá \n sea la última vez que nos veamos aquí."
