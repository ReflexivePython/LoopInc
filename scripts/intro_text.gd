extends Label

@onready var skip = $skip
@onready var day = $day
@export var button : Button

#Sprites
@onready var part_one = $part_one
@onready var part_two = $part_two
@onready var part_three = $part_three
@onready var part_four = $part_four

var typing = false
var blinking = true
var skipped = false

func _ready() -> void:
	button.pressed.connect(disable_blink)
	set_intro_text()
	blinking_text()

func disable_blink():
	blinking = false
	skipped = true

func set_skip_text():
	if Config.current_language == "en":
		skip.text = "Press 'Enter' to continue"
	else:
		skip.text = "Presiona 'Enter' para continuar"

func blinking_text():
	while true and blinking == true:
		skip.visible = false
		await get_tree().create_timer(0.3).timeout
		skip.visible = true
		await get_tree().create_timer(0.3).timeout

func set_intro_text():
	if Config.current_language == "en":
		part_one.visible = true
		part_one.play("default")
		show_text_typing("I've always wondered... Why, even though I do everything right, did I end up here?")
		await wait_for_input()
		part_one.stop()
		part_one.visible = false
		
		part_two.visible = true
		part_two.play("default")
		show_text_typing("My life has always been full of achievements, achievements that everyone praises.")
		await wait_for_input()
		part_two.stop()
		part_two.visible = false
		
		part_three.visible = true
		part_three.play("default")
		show_text_typing("I used to be the best of my class. That friend everyone wanted, that son every mother showed off, the one everyone talked about.")
		await wait_for_input()
		part_three.stop()
		part_three.visible = false
		
		part_four.visible = true
		part_four.play("default")
		show_text_typing("The truth is... All of this was really exhausting in the long run.")
		await wait_for_input()
		part_four.stop()
		part_four.visible = false
		
		show_text_typing("One day, I set out to get a prestigious job, just for the purpose of making my loved ones proud.")
		await wait_for_input()
		show_text_typing("I finally made it... At a high price: my mental health.")
		await wait_for_input()
		show_text_typing("Now I am a prisoner of my own decisions...")
		await wait_for_input()
		button.visible = false
		self.text = ""
		skip.text = ""
		day.text = "Day ???"
		blinking = false
		
		if skipped:
			return
		
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/room.tscn")
		
	else:
		part_one.visible = true
		part_one.play("default")
		show_text_typing("Siempre me he preguntado... Por qué, aunque hago todo bien, ¿terminé aquí?")
		await wait_for_input()
		part_one.stop()
		part_one.visible = false
		
		part_two.visible = true
		part_two.play("default")
		show_text_typing("Mi vida siempre ha estado llena de logros, logros que todos alaban")
		await wait_for_input()
		part_two.stop()
		part_two.visible = false
		
		part_three.visible = true
		part_three.play("default")
		show_text_typing("Solía ser el primero de la clase. Ese amigo que todos querían tener, ese hijo que todas las madres lucían, el que daba de qué hablar.")
		await wait_for_input()
		part_three.stop()
		part_three.visible = false
		
		part_four.visible = true
		part_four.play("default")
		show_text_typing("La verdad es que... Todo esto era realmente agotador a la larga.")
		await wait_for_input()
		part_four.stop()
		part_four.visible = false
		
		show_text_typing("Un día, me propuse conseguir un trabajo prestigioso, solo con el propósito de enorgullecer a mis seres queridos.")
		await wait_for_input()
		show_text_typing("Al final lo logré... Por un alto precio: mi salud mental.")
		await wait_for_input()
		show_text_typing("Ahora soy un prisionero de mis propias decisiones...")
		await wait_for_input()
		button.visible = false
		self.text = ""
		skip.text = ""
		day.text = "Día ???"
		blinking = false
		
		if skipped:
			return
		
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/room.tscn")
		

func show_text_typing(text: String, delay := 0.05) -> void:
	skip.text = ""
	self.text = ""
	typing = true
	for i in text.length():
		if skipped or get_tree() == null:
			self.text = text
			break
		
		self.text += text[i]
		await get_tree().create_timer(delay).timeout
		
	typing = false
	set_skip_text()
		
func wait_for_input() -> void:
	if skipped:
		return
	while true:
		if skipped:
			return
		await get_tree().process_frame
		if skipped or Input.is_action_just_pressed("ui_accept") and typing == false:
			break
		
