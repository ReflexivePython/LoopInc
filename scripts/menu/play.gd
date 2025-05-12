extends Control

var triggered = false

#Buttons
@onready var play = $Play
@onready var quit = $Quit
@onready var config = $Config
@onready var reset = $Reset

#Delete file
@onready var confirmation = $confirmation
@onready var confirm_label = $confirmation/Label
@onready var accept = $confirmation/yes
@onready var decline = $confirmation/no

@onready var dev = $dev
@onready var animation = $fade_out/AnimationPlayer
@onready var logo = $AnimatedSprite2D

func _ready() -> void:
	if FileAccess.file_exists("user://save.json"):
		Save.load_game()
	
	reset.pressed.connect(reset_save)
	
	logo.play("default")
	change_label_text()
	play.pressed.connect(play_game)
	config.pressed.connect(show_config_menu)
	quit.pressed.connect(quit_game)
	
	accept.pressed.connect(delete_file)
	decline.pressed.connect(return_menu)

func play_game():
	if FileAccess.file_exists("user://save.json"):
		if Day.cinematic_played and not triggered:
			triggered = true
			animation.play("fade_out")
			await animation.animation_finished
			get_tree().change_scene_to_file("res://scenes/room.tscn")
		elif not Day.cinematic_played and not triggered:
			triggered = true
			animation.play("fade_out")
			await animation.animation_finished
			get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")
	else:
		animation.play("fade_out")
		await animation.animation_finished
		get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")

func quit_game():
	get_tree().quit()
	
func show_config_menu():
	var menu_scene = preload("res://scenes/settings.tscn")
	var menu_instance = menu_scene.instantiate()
	
	add_child(menu_instance)

func reset_save():
	if FileAccess.file_exists("user://save.json"):
		confirmation.visible = true

func delete_file():
	var save_path = "user://save.json"
	var dir = DirAccess.open("user://")
	
	if dir.file_exists(save_path):
		dir.remove(save_path)
		Save.reset_game_state()
		get_tree().reload_current_scene()
	
	confirmation.visible = false

func return_menu():
	confirmation.visible = false
	
func change_label_text():
	if Config.current_language == "en":
		play.text = "Play"
		quit.text = "Quit"
		config.text = "Settings"
		confirm_label.text = "Are you sure you \n want to delete your \n save file?"
		accept.text = "Yes"
		decline.text = "No"
		
		dev.text = "By ReflexivePython"
	else:
		play.text = "Jugar"
		quit.text = " Salir"
		config.text = "  Ajustes  "
		confirm_label.text = "¿Estás seguro de que \n deseas eliminar tu \n partida?"
		accept.text = "Si"
		decline.text = "No"
		
		dev.text = "Por ReflexivePython"
