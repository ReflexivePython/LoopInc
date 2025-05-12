extends Control

var words = [
	"burnedout", "robot", "peerpressure", "multitasking",
	"emotionalsalary" , "feedback" , "excelmastering" , "titleinflation",
	"mobbing" , "productivity" , "synergy" , "overworking",
	"layoffs" , "competitivesalary" , "rotatingschedules",
	"takeonefortheteam" , "jobindependence" , "beyourownboss",
	"preachers" , "letithappen" , "iwanttobefree" , "quietquitting" , "povertywage",
	"teamfamily" , "unpaidovertime" , "cvblackhole" , "corporateghosting",
	"quietfiring" , "circleback" , "blueskythinking" , "thegreatregret"
]

var random_words = [
	"Burned Out", "Robot", "Peer Pressure", "Multitasking",
	"Emotional Salary", "Feedback", "Excel Mastering", "Title Inflation",
	"Mobbing", "Productivity", "Synergy", "Overworking",
	"Layoffs", "Competitive Salary", "Rotating Schedules",
	"Take One For The Team", "Job Independence", "Be Your Own Boss",
	"Preachers", "Let It Happen", "I Want To Be Free", "Quiet Quitting", 
	"Poverty Wage", "Team Family", "Unpaid Overtime", "CV Blackhole", 
	"Corporate Ghosting", "Quiet Firing", "Circle Back", "Blue Sky Thinking",
	"The Great Regret"
]

@onready var text_input = $LineEdit
@onready var label = $words
@onready var comment = $comments
@onready var time = $TextureProgressBar

#Button
@onready var button = $write

var time_left = 23
var actual_word
var last_input = ""


func _ready() -> void:
	if Config.is_android:
		button.visible = true
		
	button.pressed.connect(focus)
	
	set_word()
	time_left = time_left + (Day.day * 2)
	time.max_value = time_left
	
	
	text_input.text_changed.connect(write_sfx)
	text_input.text_submitted.connect(input_text)
	
	await get_tree().create_timer(3).timeout
	text_input.grab_focus()

func write_sfx(_new_text: String = ""):
	$TypingSfx.play()

func input_text(submitted_text):
	var typed_word = submitted_text.to_lower().replace(" ","")
	actual_word = actual_word.to_lower().replace(" ","")
	
	if typed_word == actual_word:
		show_comments(typed_word)
		set_word()
		text_input.text = ""
	else:
		time_left += 3
		modulate_progress()
		text_input.text = ""

func set_word():
	actual_word = random_words.pick_random()
	label.text = actual_word
	
func focus():
	text_input.grab_focus()

func modulate_progress():
	time.tint_progress = Color("ff1d14")
	await get_tree().create_timer(0.8).timeout
	time.tint_progress = Color("ffffff")

func show_comments(word):
	match word:
		"iwanttobefree","letithappen","jobindependence":
			if Config.current_language == "en":
				comment.text = "Huh, ironic."
			else:
				comment.text = "Ja, irónico."

		"multitasking","takeonefortheteam","teamfamily":
			if Config.current_language == "en":
				comment.text = "That's the attitude!"
			else:
				comment.text = "¡Esa es la actitud!"

		"burnedout","robot","peerpressure","layoffs":
			if Config.current_language == "en":
				comment.text = "We don't talk about that here"
			else:
				comment.text = "No hablamos sobre eso aquí"
		
		"quietquitting","circleback","blueskythinking":
			if Config.current_language == "en":
				comment.text = "It's good that you're \n preparing for the meeting."
			else:
				comment.text = "Qué bien que te prepares \n para la reunión."
		
		"unpaidovertime","cvblackhole","corporateghosting":
			if Config.current_language == "en":
				comment.text = "You know, it's weird to see you \n thinking about that."
			else:
				comment.text = "Sabes, es raro verte pensar en eso."


func check_if_idle():
	if text_input.text == "":
		time_left += 3
		if Config.current_language == "en":
			comment.text = "Hey! I'm watching you! Keep the work"
		else:
			comment.text = "¡Hey, te estoy viendo! Sigue trabajando"
		modulate_progress()

	elif text_input.text.to_lower().replace(" ","") != actual_word:
		if text_input.text == last_input:
			time_left += 5
			if Config.current_language == "en":
				comment.text = "Do you think that I'm stupid?"
			else:
				comment.text = "¿Crees que soy estúpido?"
			modulate_progress()
			
		elif text_input.text.length() > 30:
			time_left +=8
			if Config.current_language == "en":
				comment.text = "I thought you would do this too"
			else:
				comment.text = "También creí que harías esto"
			modulate_progress()
			
	last_input = text_input.text


var check_timer = 0.0

func _process(delta):
	
	if time_left > 0:
		time_left -= delta
		time.value = time_left
		
		check_timer += delta
		if check_timer >= 8.0:
			check_if_idle()
			check_timer = 0.0
		
	if time_left <= 0:
		Day.daily_objective -= 1
		Save.save_game()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
