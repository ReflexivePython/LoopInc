extends Button


func _ready() -> void:
	self.pressed.connect(skip_to_game)

func skip_to_game():
	Day.cinematic_played = true
	Save.save_game()
	get_tree().change_scene_to_file("res://scenes/room.tscn")
