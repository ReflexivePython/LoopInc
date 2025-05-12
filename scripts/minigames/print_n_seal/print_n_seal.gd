extends Control

var doc_scene = preload("res://scenes/doc_minigame/document.tscn")
var doc_instance = null

@onready var stressful_label = $stressful_messages

#Sfx
@onready var stamp = $StampSfx
@onready var fail = $Fail
@onready var ambiance = $OfficeAmbiance

#Phrases
var bad_en = [
	"Great! You did it horrible",
	"Is that all you got?",
	"Maybe you should put more effort on it.",
	"I can't believe you get paid for this",
	"You always do nothing"
]

var bad_es = [
	"¡Genial, lo hiciste horrible!",
	"¿Es eso todo lo que tienes?",
	"Deberías ponerle más esfuerzo a esto.",
	"No puedo creer que te pagan por esto",
	"Siempre haces nada"
]

func _ready() -> void:
	Score.goal = 10 + (Day.day * 2)
	spawn_document()
	setup_ambiance()

func setup_ambiance():
	await get_tree().create_timer(3).timeout
	ambiance.play()

func spawn_document():
	doc_instance = doc_scene.instantiate()
	add_child(doc_instance)
	var document = doc_instance.get_node("document")
	document.position = Vector2(randi_range(-150,150),randi_range(-120,0))
	
	if doc_instance.has_node("document"):
		document.finished.connect(finished_document)
		document.bad.connect(u_did_it_bad)

func finished_document():
	stamp.play(0.75)
	doc_instance.queue_free()
	spawn_document()

func u_did_it_bad():
	if Config.current_language == "en":
		stressful_label.text = bad_en.pick_random()
	else:
		stressful_label.text = bad_es.pick_random()
	fail.play(0.5)
