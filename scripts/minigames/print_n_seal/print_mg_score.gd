extends Label

@onready var score_label = $Label

func _ready() -> void:
	if Config.current_language == "en":
		self.text = "Remaining:"
	else:
		self.text = "Restantes:"

func _process(_delta: float) -> void:
	score_label.text = str(Score.goal)
