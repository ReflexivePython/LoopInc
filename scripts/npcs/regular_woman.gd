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
				return "You know, I was \n really excited to work in a place \n like this. So prestigious."
			else:
				return "Sabes, me hacía \n mucha ilusión trabajar en \n un lugar así. \n Tan prestigioso."
		2:
			if lang == "en":
				return "Hey, don't tell anyone... \n The boss called me in yesterday. He said \n he could give me a raise if I 'behave'. \n I laughed a little, but he was serious..."
			else:
				return "Hey, no se lo digas a nadie... \n Ayer el jefe me llamó. Dijo que me \n daría un aumento si 'me portaba bien'. \n Me reí un poco, pero él hablaba en serio..."
		3:
			if lang == "en":
				return "*sobs* I'm sorry... But I \n can't pretend to be okay..."
			else:
				return "*sollozos* Lo siento... Pero no \n puedo fingir estar bien..."
