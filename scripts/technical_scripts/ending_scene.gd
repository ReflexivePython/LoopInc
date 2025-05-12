extends Control

@onready var sprite = $ending_cinematic
@onready var logo = $logo
@onready var message = $final_message
@onready var pc = $screen

func _ready() -> void:
	if Config.current_language == "en":
		message.text = "How long are you going to \n wait for things to change?"
	else:
		message.text = "¿Cuánto tiempo vas a esperar \n a que las cosas cambien?"
	
	sprite.play("before_ending")
	await get_tree().create_timer(2.5).timeout
	
	sprite.play("part_one")
	await get_tree().create_timer(3.5).timeout
	
	sprite.play("part_two")
	await get_tree().create_timer(5).timeout
	
	sprite.visible = false
	write_letter()
	
	pc.visible = true
	message.visible = true
	
	await get_tree().create_timer(3).timeout
	pc.visible = false
	message.visible = false
	
	await get_tree().create_timer(1).timeout
	logo.visible = true
	await get_tree().create_timer(4).timeout
	get_tree().quit()
	
func write_letter():
	var content = ""
	var desktop_path = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	var file_path = desktop_path.path_join("Thanks.txt")
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		if Config.current_language == "es":
			content = """
Jugador

Para tí, que estás leyendo esto, quiero agradecerte de corazón por darle una oportunidad a mi juego. A decir verdad, es el primer proyecto que lanzo al público, así que espero sea bien acogido.
Lo que acabas de presenciar son horas de trabajo y dedicación que solo pudieron ser impulsadas por dos cosas: sueños y personas.
Personas que estuvieron ahí para mí, y sueños que me propulsaron a hacer lo que realmente me gusta.

Jugador, no temas
No temas a lo que nos depara el futuro. El futuro es incierto, pero esa incertidumbre suele traer cosas buenas, y si llega a traer dificultades, piensa en ellas como retos que superarás y de los cuales aprenderás mucho.

Jugador, siente
Date un tiempo para sentir, para respirar. Para sentarte en el pasto, acariciarlo, acostarse en él y luego preguntarte: ¿Cómo me siento actualmente?

Jugador, actúa
Si no te sientes bien con lo que tienes, lucha por encontrar aquello que te hace feliz, y si sabes lo que es, lucha para lograr convivir con ello siempre. Todo esto sin presiones, por supuesto. Hay personas que han llegado a esta conclusión a los 50, otros a los 14, quizá.

Jugador… Sal del bucle
Si no te sientes bien en un lugar o con lo que haces, sal del bucle. Rompe ese bucle, y crea tu propio camino. 

Gracias, jugador, por probar mi juego. Espero el mensaje, y esta carta te dejen en qué pensar.

Con cariño, y deseando próximos lanzamientos, ReflexivePython.

OS.alert("Loop breaked", "ALERT")
		"""
		else:
			content = """
			Player

To you, who are reading this, I want to sincerely thank you for giving my game a chance. Truthfully, this is the first project I've released to the public, so I hope it's well-received.
What you just witnessed are hours of work and dedication that could only have been driven by two things: dreams and people.
People who were there for me, and dreams that propelled me to do what I truly love.

Player, don't be afraid
Don't be afraid of what the future holds. The future is uncertain, but that uncertainty usually brings good things, and if it brings difficulties, think of them as challenges you will overcome and from which you will learn a lot.

Player, feel
Take some time to feel, to breathe. To sit on the grass, stroke it, lie down on it, and then ask yourself: How am I feeling right now?

Player, take action
If you don't feel good about what you have, fight to find what makes you happy, and if you know what that is, fight to live with it forever. All this without pressure, of course. Some people have come to this conclusion at 50, others at 14, perhaps.

Player... Break out of the loop
If you don't feel good about a place or what you do, break out of the loop. Break that loop, and create your own path.

Thank you, player, for trying my game. I hope the message and this letter give you something to think about.

Love, and looking forward to future releases, ReflexivePython.

OS.alert("Loop broken", "ALERT")"""
		file.store_string(content)
		file.close()
	else:
		print("I Guess the letter could'nt be created")
