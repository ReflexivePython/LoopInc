extends Area2D

var body_inside = false
@onready var interact = $interact
var message = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' to continue..."
	else:
		interact.text = "Pulsa 'E' para continuar..."

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and body_inside == true:
		get_tree().change_scene_to_file("res://scenes/ending_scene.tscn")
