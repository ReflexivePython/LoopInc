extends ColorRect

@onready var title = $Label
@onready var counter = $counter

func _ready() -> void:
	countdown()
	if Config.current_language == "en":
		title.text = "Instructions"
	else:
		title.text = "Instrucciones"

func countdown():
	counter.text = "3"
	await get_tree().create_timer(1).timeout
	counter.text = "2"
	await get_tree().create_timer(1).timeout
	counter.text = "1"
	await get_tree().create_timer(1).timeout
	self.visible = false
	
	$OfficeAmbiance.play()
