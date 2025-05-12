extends CanvasLayer

@onready var objective = $objective

func _ready() -> void:
	await  get_tree().create_timer(2).timeout
	change_objective()
	objective.visible = true

func change_objective():
	if Day.day == 7:
		if Config.current_language == "en":
			objective.text = "Today's objective: \n  - Free yourself."
		else:
			objective.text = "Objetivo de hoy: \n  - Libérate."
	elif Day.daily_objective <= 0:
		if Config.current_language == "en":
			objective.text = "Today's objective: \n  - Go sleep."
		else:
			objective.text = "Objetivo de hoy: \n  - Ve a dormir."
	elif Day.daily_objective == 1:
		if Config.current_language == "en":
			objective.text = "Today's objective: \n  - Do " + str(Day.daily_objective) + " task."
		else:
			objective.text = "Objetivo de hoy: \n  - Haz " + str(Day.daily_objective) + " tarea."
	else:
		if Config.current_language == "en":
			objective.text = "Today's objective: \n  - Do " + str(Day.daily_objective) + " tasks."
		else:
			objective.text = "Objetivo de hoy: \n  - Haz " + str(Day.daily_objective) + " tareas."
