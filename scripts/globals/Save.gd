extends Node


func save_game():
	var data = {
		"day": Day.day,
		"lang": Config.current_language,
		"mute": Config.muted,
		"daily_objective" : Day.daily_objective,
		"played" : Day.cinematic_played
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func load_game():
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		
		if data == null or typeof(data) != TYPE_DICTIONARY:
			reset_game_state()
			save_game()
			return
		
		if typeof(data) == TYPE_DICTIONARY:
			var current_day = data["day"]
			var lang = data["lang"]
			var mute = data["mute"]
			var played
			var daily_obj
			
			if data.has("played"):
				played = data["played"]
			
			if data.has("daily_objective"):
				daily_obj = data["daily_objective"]
			
			Day.day = int(current_day)
			Config.current_language = lang
			Config.muted = bool(mute)
			Config.set_mute()
			
			if daily_obj != null:
				if daily_obj < 0:
					Day.set_objective()
				else:
					Day.daily_objective = int(daily_obj)
			else:
				Day.set_objective()
			
			if played != null:
				Day.cinematic_played = bool(played)
			else:
				Day.cinematic_played = false


func reset_game_state():
	Day.day = 0
	Config.current_language = "en"
	Config.muted = false
	
	Config.set_mute()
	Day.advance_day()
