extends Area2D

var body_inside = false
var interacted = false
@onready var bubble = $Label

var lang = Config.current_language

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false

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
		1:
			if lang == "en":
				return "Looks like you found an easter egg :>"
			else:
				return "Parece que encontraste un easter egg :>"
		2:
			if lang == "en":
				return "So that's why I'm going to \n tell you the story of Loop Inc."
			else:
				return "Así que por eso, te contaré \n la historia de Loop Inc"
		3:
			if lang == "en":
				return "My original idea was for it to just be \n an animation-type minigame, you know?"
			else:
				return "Mi idea original es que solo fuera \n un minijuego tipo animación, ¿Sabías?"
		4:
			if lang == "en":
				return "But as I progressed, ideas kept coming to me, \n I couldn't leave them hanging."
			else:
				return "Pero conforme iba avanzando las ideas iban \n brotando, no podía dejarlas en el aire."
		5:
			if lang == "en":
				return "I wanted it to be an intimate game, for my friends. \n But maybe it's time for other people to see my projects. \n That's why I've worked harder than ever."
			else:
				return "Quería que fuera un juego íntimo, para mis amigos. \n Pero quizá es momento de que otras personas vean mis proyectos. \n Por eso me he esforzado como nunca."
		6:
			if lang == "en":
				return "I put my heart and soul into this project, \n and I hope you, the player, appreciate it, more \n for the message than anything else."
			else:
				return "En este proyecto puse mi mente y corazón, y \n espero tú jugador, lo aprecies, \n más por el mensaje que por nada."
		7:
			if lang == "en":
				return "Thanks for playing Loop Inc, now go out \n and break your own loop c:"
			else:
				return "Gracias por jugar Loop Inc, ahora sal, \n y rompe tu propio bucle c:"
