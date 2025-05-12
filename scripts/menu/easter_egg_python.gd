extends TextureButton

@onready var hiss = $Hiss
var playing = false

func _ready() -> void:
	self.pressed.connect(on_pressed)

func on_pressed():
	if not playing:
		playing = true
		hiss.play(2.2)
		await hiss.finished
		playing = false
