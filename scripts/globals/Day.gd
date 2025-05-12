extends Node

var day = 0
var cinematic_played: bool =  false

var day_finished = false
var daily_objective = 0

func _ready() -> void:
	advance_day()

func advance_day():
	if day >= 7:
		day = 7
	
	day += 1
	day_finished = false
	set_objective()

func set_objective():
	match day:
		1:
			daily_objective = 3
		2:
			daily_objective = 4
		3:
			daily_objective = 5
		4:
			daily_objective = 6
		5:
			daily_objective = 7
		6:
			daily_objective = 10
		7:
			daily_objective = 1
