extends Node2D

@onready var regular_woman = $regular_woman
@onready var box = $box
@onready var hiring_sign = $hiring_sign

func _ready() -> void:
	if Day.day > 3:
		disable_node(regular_woman)
		hiring_sign.visible = true
	else:
		disable_node(box)

func disable_node(node):
	node.visible = false
	node.monitorable = false
	node.monitoring = false
