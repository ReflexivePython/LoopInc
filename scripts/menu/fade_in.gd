extends ColorRect

@onready var animation = $AnimationPlayer

func _ready() -> void:
	animation.play("fade_in")
