extends Area2D

@onready var interact = $interact
@onready var message = $Label

#SFX
@onready var clock_sfx = $ClockSfx

var lang = Config.current_language
var body_inside = false
var showing = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	set_text()
	set_message(get_hour())

func _input(_event: InputEvent) -> void:
	var pressed = Input.is_action_just_pressed("E")
	var entered = body_inside == true
	
	if pressed and entered:
		if showing:
			return
		
		showing = true
		message.visible = true
		await get_tree().create_timer(5).timeout
		message.visible = false
		showing = false

func on_body_entered(body):
	if body.name == "MC":
		body_inside = true
		clock_sfx.play()
		interact.visible = true
		
func on_body_exited(body):
	if body.name == "MC":
		body_inside = false
		interact.visible = false

func get_hour():
	var datetime = Time.get_datetime_dict_from_system()
	var hour = datetime.hour
	
	return hour

func set_text():
	if lang == "en":
		interact.text = "See the time"
	else:
		interact.text = "Ver la hora"

func set_message(hour):
	var morning = [6,7,8,9,10,11]
	var afternoon = [12,13,14,15,16,17,18]
	var night = [19,20,21,22,23]
	var dawn = [0,1,2,3,4,5]
	
	var hour_str = str(hour)
	
	if hour in morning:
		if lang == "en":
			message.text = "It's " + hour_str + " A.M. \n Are you ready to work?"
		else:
			message.text = "Son las " + hour_str + " A.M. \n ¿Estás listo para trabajar?"
	elif hour in afternoon:
		if lang == "en":
			message.text = "It's " + hour_str + " P.M. \n You should be working already"
		else:
			message.text = "Son las " + hour_str + " P.M. \n Ya deberías estar trabajando"
	
	elif hour in dawn:
		if lang == "en":
			message.text = "It's " + hour_str + " A.M. \n Hey, I really care about you \n Please sleep well, player"
		else:
			message.text = "Son las " + hour_str + " A.M. \n Hey, de verdad me preocupo por tí \n Por favor duerme bien, jugador"
			
	elif hour in night:
		if lang == "en":
			message.text = "It's " + hour_str + " P.M. \n You should be sleeping, player"
		else:
			message.text = "Son las " + hour_str + " P.M. \n Deberías estar durmiendo, jugador"
	
	else:
		if lang == "en":
			message.text = "Did you find a bug? \n Or do you live in Mars, somehow?"
		else:
			message.text = "¿Encontraste un bug? \n ¿O de alguna forma vives en Marte?"
