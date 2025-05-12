extends Area2D

var body_inside = false
@onready var interact = $interact

var last_minigame: String = ""

var minigames = [
	"res://scenes/doc_minigame/print_n_seal.tscn",
	"res://scenes/type_minigame/write_faster.tscn",
	"res://scenes/ia_m_a_good_worker/ia_m_a_good_worker.tscn",
	"res://scenes/weekly_classifieds/weekly_classifieds.tscn"
]

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	if Config.current_language == "en":
		interact.text = "Press 'E' \n to work..."
	else:
		interact.text = "Pulsa 'E' \n para trabajar..."

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
		var next_game: String
		
		if last_minigame and randf() > 0.9:
			var available_games = minigames.filter(func(game): return game != last_minigame)
			next_game = available_games.pick_random()
		else:
			next_game = minigames.pick_random()
		
		last_minigame = next_game
		get_tree().change_scene_to_file(next_game)
