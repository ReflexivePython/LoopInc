extends Control

#labels
@onready var mail_label = $mail
@onready var answer = $answer
@onready var archive = $archive
@onready var delete = $delete
@onready var user_name = $user
@onready var brand = $brand

#SFX
@onready var sfx = $Clic

var lang = Config.current_language

#load data
var data = preload("res://scripts/minigames/weekly_classifieds/mails.gd")
var mail_data
var current_mail_type = ""

#Functional
var objective = 3
var max_value

func _ready() -> void:
	objective = objective + (Day.day * 2)
	max_value = objective
	
	$TextureProgressBar.max_value = objective
	$TextureProgressBar.value = objective
	mail_data = data.new()
	
	if lang == "en":
		answer.text = "Answer"
		archive.text = "Archive"
		delete.text = "Delete"
		user_name.text = "Hello, 45301!"
		brand.text = "A LoopCorps™ program"
	else:
		answer.text = "Atender"
		archive.text = "Archivar"
		delete.text = "Eliminar"
		user_name.text = "¡Hola, 45301!"
		brand.text = "Un programa de LoopCorps™"
	
	answer.pressed.connect(answer_pressed)
	archive.pressed.connect(archive_pressed)
	delete.pressed.connect(delete_pressed)
	
	load_mail()

func load_mail():
	var mail = mail_data.mail_pool.pick_random()
	mail_label.text = mail.text[lang]
	current_mail_type = mail.type

func answer_pressed():
	apply_effect("answer")
	if sfx.is_inside_tree():
		sfx.play()

func archive_pressed():
	apply_effect("archive")
	if sfx.is_inside_tree():
		sfx.play()

func delete_pressed():
	apply_effect("delete")
	if sfx.is_inside_tree():
		sfx.play()

func apply_effect(button):
	var selected_type = ""
	match button:
		"answer":
			selected_type = "green"
		"archive":
			selected_type = "blue"
		"delete":
			selected_type = "red"
	
	if selected_type == current_mail_type:
		objective -= 1
		$TextureProgressBar.value = objective
	else:
		objective = clamp(objective + 1,0,max_value)
		$TextureProgressBar.value = objective
		
	if objective <= 0:
		Day.daily_objective -= 1
		Save.save_game()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	load_mail()
