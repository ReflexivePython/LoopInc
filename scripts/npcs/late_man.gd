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
				return "*puff* I was only two minutes late...\n What's new?"
			else:
				return "*puff* Llegué solo dos minutos tarde... \n ¿Qué hay de nuevo?"
		2:
			if lang == "en":
				return "The boss told me that if I \n continued to be late, he would deduct every \n minute like a day. What does it matter?"
			else:
				return "El jefe me dijo que si seguía \n llegando tarde me descontaría cada \n minuto como un día. ¿Qué más da?"
		3:
			if lang == "en":
				return "That philosopher guy keeps telling me \n thoughtful things about me. He's kind of nosy."
			else:
				return "Ese tipo filósofo no para de decirme \n cosas reflexivas sobre mí. Es algo metiche."
		4:
			if lang == "en":
				return "I was only 30 minutes late today, \n they should be grateful I came..."
			else:
				return "Hoy llegué solo 30 minutos tarde, \n deberían agradecer que vine..."
		5:
			if lang == "en":
				return "Sometimes when I look in the mirror I \n look so exhausted... Get out of my mind, philosopher!"
			else:
				return "A veces cuando veo el espejo me veo \n tan agotado... ¡Aléjate de mi mente, filósofo!"
		6:
			if lang == "en":
				return "Three hours late... That's definitely a new record."
			else:
				return "Tres horas tarde... Sin duda es un nuevo récord."
		7:
			if lang == "en":
				return "*huff* At least no one saw me arriving late..."
			else:
				return "*huff* Al menos nadie me vio llegar tarde..."
