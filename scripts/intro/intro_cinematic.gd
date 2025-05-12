extends Node

#Cinematic Sprites
@onready var part_one = $part_one
@onready var part_two = $part_two
@onready var part_three = $part_three
@onready var part_four = $part_four
@onready var part_five = $part_five
@onready var part_six = $part_six

#Android button
@onready var advance_button = $advance

#Conditionals
var skipped = false
var typing = false
var blinking = true
var finished = false

#Labels
@onready var skip = $skip
@export var button : Button
@onready var day = $day


#Ready
func _ready() -> void:
	if Config.is_android:
		advance_button.visible = true
	advance_button.pressed.connect(_on_advance_button_pressed)
	
	
	var intro_dialogue_en = [
	{"text" : "I've always wondered... what do I really want to achieve, being stuck in a place I dislike?",
	"sprite" : part_one},
	{"text" : "My life has been full of accomplishments. Achievements everyone applauds, like medals of success.",
	"sprite" : part_two},
	{"text" : "I was top of the class. The ideal friend, the exemplary son. The one everyone spoke of with pride.",
	"sprite" : part_three},
	{"text" : "But truthfully... it was exhausting.",
	"sprite" : part_four},
	{"text" : "So, wanting to prove I could stand on my own, I ventured to secure a stable job.",
	"sprite" : part_five},
	{"text" : "And I succeeded. Though the cost was high: my mental health.",
	"sprite" : part_six},
	{"text" : "Now I just live day to day. How much longer will this go on?",
	"sprite" : part_one,
	"day" : "Day 1"}
]
	var intro_dialogue_es = [
	{"text" : "Siempre me he preguntado… qué es lo que quiero lograr, estando en un lugar que no me agrada.",
	"sprite" : part_one},
	{"text" : "Mi vida ha estado llena de logros. Logros que todos aplauden, como si fueran medallas de éxito.",
	"sprite" : part_two},
	{"text" : "Fui el primero de la clase. El amigo ideal, el hijo ejemplar. Ese del que todos hablaban con orgullo.",
	"sprite" : part_three},
	{"text" : "Pero, siendo sincero… todo eso era agotador.",
	"sprite" : part_four},
	{"text" : "Así que, queriendo demostrar que haría las cosas para valerme por mí mismo, me aventuré a conseguir un empleo estable",
	"sprite" : part_five},
	{"text" : "Y lo conseguí. Aunque el precio fue alto: mi salud mental.",
	"sprite" : part_six},
	{"text" : "Solo vivo y pienso en el día a día. ¿Por cuánto más lo haré?",
	"sprite" : part_one,
	"day" : "Día 1"}
]
	
	
	#Dialogue logic
	button.pressed.connect(disable_blink)
	set_skip_text()
	blinking_text()
	
	if Config.current_language == "en":
		await show_dialogue(intro_dialogue_en)
	else:
		await  show_dialogue(intro_dialogue_es)
		

#Functions

func show_dialogue(dialogue_array : Array):
	for item in dialogue_array:
		if skipped:
			break
		
		if item.has("sprite"):
			show_cinematic(item["sprite"])
		
		await show_text_typing(item["text"])
		await wait_for_input()
		
		if item.has("sprite"):
			hide_cinematic(item["sprite"])
		
		if item.has("day"):
			hide_cinematic(item["sprite"])
			skip.text = ""
			self.text = ""
			day.text = item["day"]
			finished = true
		
		if finished == true:
			await get_tree().create_timer(3).timeout
			Day.cinematic_played = true
			Save.save_game()
			get_tree().change_scene_to_file("res://scenes/room.tscn")
		
	self.text = ""

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

func disable_blink():
	blinking = false
	skipped = true

func blinking_text():
	while true and blinking == true:
		skip.visible = false
		await get_tree().create_timer(0.3).timeout
		skip.visible = true
		await get_tree().create_timer(0.3).timeout


func set_skip_text():
	if Config.current_language == "en":
		skip.text = "Press 'Enter' to continue"
	else:
		skip.text = "Presiona 'Enter' para continuar"
		
func wait_for_input() -> void:
	if skipped:
		return
	while true:
		if skipped:
			return
		await get_tree().process_frame
		if skipped or Input.is_action_just_pressed("ui_accept") and typing == false:
			break

func show_cinematic(sprite : AnimatedSprite2D):
	sprite.visible = true
	sprite.play("default")
	
func hide_cinematic(sprite : AnimatedSprite2D):
	sprite.visible = false
	sprite.stop()

func _on_advance_button_pressed():
	var press_event := InputEventAction.new()
	press_event.action = "ui_accept"
	press_event.pressed = true
	Input.parse_input_event(press_event)
	
	await  get_tree().create_timer(0.3).timeout
	
	var release_event := InputEventAction.new()
	release_event.action = "ui_accept"
	release_event.pressed = false
	Input.action_release("ui_accept")
	advance_button.release_focus()
