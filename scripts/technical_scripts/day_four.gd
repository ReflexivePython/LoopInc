extends Control

@onready var cinematic = $cinematic
@onready var fade = $mc/fade
@onready var message = $message
@onready var pc = $pc
@onready var keys = $mc/keys
@onready var mc = $mc

func _ready() -> void:
	if Config.current_language == "en":
		message.text = "How long are you going \n to wait for things \n to change?"
	else:
		message.text = "¿Cuánto tiempo vas \n a esperar a que las \n cosas cambien?"
	
	play_cinematic()
	

func show_keys():
	keys.visible = true
	await  get_tree().create_timer(3).timeout
	keys.visible = false
	

func play_cinematic():
	cinematic.play("fade_in")
	await  get_tree().create_timer(2).timeout
	
	show_keys()
	
	cinematic.play("walk")
	await  get_tree().create_timer(8).timeout
	
	cinematic.play("fade_out")
	mc.play("idle")
	await  get_tree().create_timer(2).timeout
	pc.visible = true
	message.visible = true
	
	await  get_tree().create_timer(5).timeout
	pc.visible = false
	message.visible = false
	cinematic.play("fade_in")
	mc.play("walk")
	
	await  get_tree().create_timer(2).timeout
	cinematic.play("walk(slow)")
	
	await  get_tree().create_timer(15).timeout
	get_tree().change_scene_to_file("res://scenes/room.tscn")
