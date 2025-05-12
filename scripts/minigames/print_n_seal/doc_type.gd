extends Area2D

@export var seal = Sprite2D
@onready var sprite = $Sprite2D
var sealed = false
signal finished
signal bad

#Android Input
@export var left_area = Area2D
@export var right_area  = Area2D

var type = ["good","bad"]
var choosen_type = ""

func _ready() -> void:
	choosen_type = type.pick_random()
	setup_doc(choosen_type)
	
	if Config.is_android:
		left_area.input_event.connect(_on_left_area_pressed)
		right_area.input_event.connect(_on_right_area_pressed)

func setup_doc(type_doc):
	match type_doc:
		"good":
			sprite.texture = preload("res://sprites/minigames/print_n_seal/doc.png")
		"bad":
			sprite.texture = preload("res://sprites/minigames/print_n_seal/doc_two.png")

func _input_event(_viewport, event, _shape_idx):
	if not (event is InputEventMouseButton and event.pressed and not sealed):
		return
	match choosen_type:
		"good":
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					if Score.goal <= 1:
						Day.daily_objective -= 1
						Save.save_game()
						get_tree().change_scene_to_file("res://scenes/main.tscn")
						return
					seal_doc()
				
				MOUSE_BUTTON_RIGHT:
					emit_fail()
		"bad":
			match event.button_index:
				MOUSE_BUTTON_RIGHT:
					if Score.goal <= 1:
						Day.daily_objective -= 1
						Save.save_game()
						get_tree().change_scene_to_file("res://scenes/main.tscn")
						return
					seal_doc()
				
				MOUSE_BUTTON_LEFT:
					emit_fail()

func _on_left_area_pressed(_viewport, event, _shape_idx):
	if not (event is InputEventScreenTouch and event.pressed and not sealed):
		return

	if choosen_type == "good":
		seal_doc()
		if Score.goal < 1:
			Day.daily_objective -= 1
			Save.save_game()
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		emit_fail()

func _on_right_area_pressed(_viewport, event, _shape_idx):
	if not (event is InputEventScreenTouch and event.pressed and not sealed):
		return

	if choosen_type == "bad":
		seal_doc()
		if Score.goal < 1:
			Day.daily_objective -= 1
			Save.save_game()
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		emit_fail()

func seal_doc():
	if choosen_type == "good":
		seal.texture = preload("res://sprites/minigames/print_n_seal/seal.png")
	else:
		seal.texture = preload("res://sprites/minigames/print_n_seal/seal_two.png")
	
	sealed = true
	Score.change_score(-1)
	seal.global_position = get_global_mouse_position()
	await get_tree().create_timer(0.5).timeout
			
	finished.emit()
	sealed = false

func emit_fail():
	Score.goal += 1
	finished.emit()
	bad.emit()
	sealed = false
