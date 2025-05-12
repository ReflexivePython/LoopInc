extends Node

var mail_pool = [
	{
		"type": "green", #response
		"text": {
			"es": """Solicitud de reunión del jefe
			Equipo,
			
			Quiero que hoy hagan parte de una excelente reunión:
			'Consejos para sobrevivir al desempleo' la cual se llevará
			a cabo a las 2 p.m.
			
			¡No se la pierdan!""",
		
			"en": """Meeting request from the boss
			Team,
			
			I want you to be part of an excellent meeting today:
			'Tips for Surviving Unemployment' which will be held at
			2 p.m.
			
			Don't miss it!"""
		}
	},
	{
		"type": "blue", #archive
		"text": {
			"es": """Informe de gastos trimestrales
			
			Tras varios análisis, se ha detectado que estas son las principales
			razones de gastos en la compañía:
			
			Capacitaciones a personal nuevo, toallas de papel
			y salsa de mayonesa.""",
			
			"en": """Quarterly expense report
			
			After several analyses, it was found that these are the
			main reasons for the company's expenses:
			
			Training for new staff, paper towels, and
			mayonnaise sauce."""
		}
	},
	{
		"type": "red", #ignore
		"text": {
			"es": """Consigue diamantes en 5 minutos
			
			Anteriormente, tenías que ir a las capa Y 11,
			¡pero ahora todo ha cambiado! Tienes que ir
			a la capa Y -59 """,
			
			"en": """Get diamonds in 5 minutes
			
			Previously, you had to go to layer Y 11, but now
			everything has changed! You have to
			go to layer Y -59"""
		}
	},
	{
		"type": "green", #response
		"text": {
			"es": """Acerca de tu desempeño
			
			Hola 45301, recientemente notamos que tu productividad
			ha disminuido mucho.
			
			Sigue trabajando, de lo contrario, ve desocupando
			tu cubículo""",
		
			"en": """About your performance
			
			Hi 45301, we recently noticed that your
			productivity has decreased significantly.
			
			Keep working; otherwise, please clear
			your cubicle."""
		}
	},
	{
		"type": "blue", #archive
		"text": {
			"es": """Resultados de elecciones de personal
			
			Después de las elecciones de la semana anterior, se
			ha determinado que el siguiente personal asciende a petición
			del jefe: ¡Felicidades para el Antiguo!""",
			
			"en": """Staff Election Results
			
			Following last week's elections, the following staff
			members have been promoted at the request of the Boss:
			Congratulations to the Old One!"""
		}
	},
	{
		"type": "red", #ignore
		"text": {
			"es": """Animes más vistos
			
			Estos son los animes más vistos de la temporada:
				1- Karuto
				2- One Hundred Piece
				3- San Francisco Ghoul""",
			
			"en": """Most-watched anime
			
			These are the most-watched anime
			of the season:
				1- Karuto
				2- One Hundred Piece
				3- San Francisco Ghoul"""
		}
	},
	{
		"type": "green", #response
		"text": {
			"es": """La hora de salida es relativa
			
			Equipo, recuerden que, la hora de salida es relativa,
			pero la hora de entrada siempre debe de ser la misma.
			
			Atentamente, su querido jefe.""",
		
			"en": """The time you leave is relative.
			
			Team, remember that the time you leave is relative,
			but the time you start must always be the same.
			
			Sincerely, your dear boss."""
		}
	},
	{
		"type": "blue", #archive
		"text": {
			"es": """Encuesta de satisfacción laboral
			
			El día de mañana se llevará a cabo una encuesta de
			satisfacción laboral por parte de Recursos Laborales.
			
			Esperamos sus mejores respuestas :D""",
			
			"en": """Job Satisfaction Survey
			
			A job satisfaction survey will be conducted
			tomorrow by Laboral Resources.
			
			We look forward to your best responses :D"""
		}
	},
	{
		"type": "red", #ignore
		"text": {
			"es": """¿¡La nueva pareja de Dustin!?
			
			En la última entrevista por el salón de la fama, Dustin
			se atrevió a afirmar que cuenta con una nueva pareja,
			¡y se casarán en 4 días!""",
			
			"en": """Dustin's new partner!?
			
			In the latest Hall of Fame interview, Dustin dared
			to say he has a new partner, and they'll be getting
			married in 4 days!"""
		}
	},
	{
		"type": "green", #response
		"text": {
			"es": """Nueva política de ahorro de energía

	A partir de hoy, los monitores se apagarán automáticamente
	cada 5 minutos para 'fomentar la creatividad en la oscuridad'.
	Respondan con su método favorito para ver pantallas apagadas.

	Atentamente, el Departamento de Productividad Nocturna.""",
		
			"en": """New Energy-Saving Policy

	Starting today, monitors will shut off automatically
	every 5 minutes to 'foster creativity in the dark'.
	Reply with your favorite method to view blank screens.

	Sincerely, the Nocturnal Productivity Department."""
		}
	},
	{
		"type": "blue", #archive
		"text": {
			"es": """Actualización de contrato

	Se ha añadido la cláusula 17-B: 'El alma del empleado
	pasa a ser propiedad de LoopCorps en caso de muerte en horario laboral'.
	Firmen en el baño a las 3 AM.

	Recursos Humanos.""",
			
			"en": """Contract Update

	Clause 17-B has been added: 'The employee's soul
	becomes property of LoopCorps if death occurs during work hours'.
	Sign in the bathroom at 3 AM.

	Human Resources."""
		}
	},
	{
		"type": "red", #ignore
		"text": {
			"es": """¡El café está poseído!

	Varios empleados reportan que la máquina de café
	susurra 'renuncia' cuando crees que estás solo.
	¿Alguien más lo ha escuchado o soy yo?
	
	-Anónimo""",
			
			"en": """The Coffee Machine is Possessed!

	Multiple employees report the coffee machine
	whispers 'quit' when you think you're alone.
	Has anyone else heard it or is it just me?
	
	-Anon"""
		}
	},
	{
		"type": "green", #response
		"text": {
			"es": """Encuesta de felicidad obligatoria

	Califica del 1 al 10 tu felicidad en LoopCorps.
	*Nota: Las respuestas inferiores a 8 requerirán
	una sesión de 'reeducación motivacional'*

	Departamento de la Alegría.""",
		
			"en": """Mandatory Happiness Survey

	Rate your happiness at LoopCorps from 1 to 10.
	*Note: Scores below 8 will require
	a 'motivational reeducation' session*

	Department of Joy."""
		}
	},
	{
		"type": "blue", #archive
		"text": {
			"es": 
"""Recordatorio: Uso de aire acondicionado

El uso de aire acondicionado está limitado a diez
 minutos por persona.
 No se les ocurra consumir más de lo debido

Atentamente, Secretaría General""",
			
			"en": """Reminder: Use of air conditioning

Air conditioning use is limited to ten minutes per person.
Don't overuse it.

Sincerely, General Secretariat"""
		}
	},
	{
		"type": "red", #ignore
		"text": {
			"es": """¡El jefe es un holograma!

	Fuentes no confirmadas dicen que el 'jefe' es en realidad
	un holograma de los años 80. ¿Por qué nadie ha visto
	sus pies? Investigaremos.""",
			
			"en": """The Boss is a Hologram!

	Unconfirmed sources say the 'boss' is actually
	an 80s hologram. Why has no one seen his feet?
	We'll investigate."""
		}
	}
]
