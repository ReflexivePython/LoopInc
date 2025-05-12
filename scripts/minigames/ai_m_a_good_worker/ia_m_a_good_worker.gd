extends Control

#Load items
@onready var karen = $k_a_r_e_n_
@onready var message = $message
@onready var option_one = $option_one
@onready var option_two = $option_two
@onready var option_three = $option_three
@onready var score = $points_label
@onready var anim_score = $points_label/AnimationPlayer
@onready var progress = $ProgressBar
@onready var warns = $warns

#Sfx
@onready var success = $Success
@onready var wrong = $Wrong

var data = preload("res://scripts/minigames/ai_m_a_good_worker/questions.gd")
var dialog_data
var lang = Config.current_language

#Work variables
var compliance_level = 0
var objective = 20

var effect_one
var effect_two
var effect_three

#Position variables
var og_pos_one
var og_pos_two 
var og_pos_three 

var possible_pos 

#Reactions
#Happy
var happy_en = ["Yes! That's right!", "That's correct!", "You surprisingly did it well!",
"Amazing!", "Correct!", "You are a good ro- ...worker!", "That's my super worker!"]

var happy_es = [
	"¡Sí! ¡Correcto!", "¡Así es!", 
	"¡Sorprendentemente lo hiciste bien!", "¡Increíble!", 
	"¡Correcto!", "Eres un buen robo... digo, \n ¡trabajador!", 
	"¡Ese es mi súper empleado!"
]

#Neutral
var neutral_en = ["I don't think so...", "Hmm... No", "That's not correct",
"No, follow the guide", "Have you lost your Spirit?", "I said no..."]

var neutral_es = [
	"No creo que sea correcto...", "Mmm... No", "Eso no está bien",
	"No, sigue el procedimiento", "¿Perdiste tu espíritu laboral?",
	"Dije que no..."
]

#Angry
var angry_en = ["You Idiot! Don't say that!", "Use well that head of yours!",
"Gosh... You are so pathetic", "Why I trusted you?", "I do it better, knucklehead!",
"... Big Corporative Idiot"]

var angry_es = [
	"¡Idiota! ¡No digas eso!", "¡Usa bien esa cabeza tuya!", 
	"Dios... Eres patético", "¿Por qué confié en ti?", 
	"¡Yo lo hago mejor, imbécil!", "... Idiota corporativo"
]


func _ready() -> void:
	og_pos_one = option_one.position
	og_pos_two = option_two.position
	og_pos_three = option_three.position
	
	possible_pos = [og_pos_one, og_pos_two, og_pos_three]
	
	dialog_data = data.new()
	score.visible = false
	
	karen.play("neutral")
	objective = objective + (Day.day * 2)
	progress.max_value = objective
	load_question()
	
	option_one.pressed.connect(option_one_pressed)
	option_two.pressed.connect(option_two_pressed)
	option_three.pressed.connect(option_three_pressed)

func load_question():
	var question_data = dialog_data.dialog_pool.pick_random()
	message.text = question_data.question[lang]
	
	var positions = possible_pos.duplicate()
	positions.shuffle()
	
	var texts = [
		question_data.options[0].text[lang],
		question_data.options[1].text[lang],
		question_data.options[2].text[lang]
	]
	
	var effects = [
		question_data.options[0].effect,
		question_data.options[1].effect,
		question_data.options[2].effect
	]

	var buttons = [option_one, option_two, option_three]
	
	for i in buttons.size():
		buttons[i].text = texts[i]
		buttons[i].position = positions[i]
		buttons[i].set_meta("effect", effects[i])

	

func option_one_pressed():
	apply_effect(option_one)
	if success.is_inside_tree():
		success.play(0.2)
	play_warn("good")

func option_two_pressed():
	apply_effect(option_two)
	play_warn("neutral")

func option_three_pressed():
	apply_effect(option_three)
	if wrong.is_inside_tree():
		wrong.play()
	play_warn("bad")

func play_warn(type):
	match type:
		"good":
			if lang == "en":
				warns.text = happy_en.pick_random()
			else:
				warns.text = happy_es.pick_random()
		"neutral":
			if lang == "en":
				warns.text = neutral_en.pick_random()
			else:
				warns.text = neutral_es.pick_random()
		"bad":
			if lang == "en":
				warns.text = angry_en.pick_random()
			else:
				warns.text = angry_es.pick_random()
	

func apply_effect(button):
	var effect = button.get_meta("effect")
	compliance_level += effect
	
	if effect > 0:
		score.text = "+" + str(effect)
	else:
		score.text = str(effect)
	
	var color = "White"
	if effect > 0:
		karen.play("happy")
		color = "Green"
	elif effect < 0:
		karen.play("angry")
		color = "Red"
	else:
		karen.play("neutral")
	
	score.add_theme_color_override("font_color", color)
	anim_score.play("score")
	progress.value = compliance_level
	
	if compliance_level >= objective:
		Day.daily_objective -= 1
		Save.save_game()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	load_question()
