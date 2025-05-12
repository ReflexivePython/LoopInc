extends Area2D

@onready var interact = $interact
@onready var audio_player = $AudioStreamPlayer2D

@onready var tunning_sfx = $TunningSfx

var body_inside = false
var is_on = false

var music = [preload("res://music/radio/c418 - Krank.mp3"),
preload("res://music/radio/C418 - phlips.mp3"),
preload("res://music/radio/C418 - anthem.mp3")]

var texts = {
	"en": {
		"turn_on": "Turn On",
		"turn_off": "Turn Off"
	},
	"es": {
		"turn_on": "Encender",
		"turn_off": "Apagar"
	}
}

var lang = Config.current_language

func _ready() -> void:
	update_interact_label()
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	audio_player.finished.connect(turn_off)

func _input(_event: InputEvent) -> void:
	var pressed = Input.is_action_just_pressed("E")
	var entered = body_inside == true
	
	if pressed and entered:
		if is_on:
			turn_off()
		else:
			turn_on()

func turn_on():
	if is_on:
		return
	
	is_on = true
	var selected_music = music.pick_random()
	audio_player.stream = selected_music
	audio_player.play()
	update_interact_label()
	
func turn_off():
	is_on = false
	audio_player.stop()
	update_interact_label()

func update_interact_label():
	var key = "turn_off" if is_on else "turn_on"
	
	interact.text = texts[lang][key]

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		tunning_sfx.play()

func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false
