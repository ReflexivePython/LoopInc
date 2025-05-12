extends Node

var dialog_pool = [
	{
		"question": {
			"es": "Necesito estos documentos para el día de ayer.",
			"en": "I need these documents for yesterday."
		},
		"options": [
			{
				"text": {
					"es": "¡Claro! Retrocederé el tiempo.",
					"en": "Sure! I’ll just reverse time."
				},
				"effect": +5
			},
			{
				"text": {
					"es": "Ehh... ¿Está bien?",
					"en": "Hmm... Ok?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Entendido, lo mando hace 3 días.",
					"en": "Got it. Sent it three days ago."
				},
				"effect": -3
			}
		]
	},
	{
		"question": {
			"es": "¿Puedes reemplazar a tu compañero que enfermó? \n No se te pagarán horas extra",
			"en": "Can you replace your colleague who fell ill? \n You will not be paid overtime."
		},
		"options": [
			{
				"text": {
					"es": "Puedo hacer eso y más",
					"en": "I can do that and more"
				},
				"effect": +10
			},
			{
				"text": {
					"es": "Si quieres también respiro por ellos",
					"en": "If you want, I'll also breathe for them."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "¿Qué harán? Pagarme con pizza?",
					"en": "What will you do? Pay me with pizza?"
				},
				"effect": -8
			}
		]
	},
	{
		"question": {
			"es": "Haremos recorte de personal pronto. \n Si te esfuerzas no quedarás fuera",
			"en": "We'll be cutting staff soon.\n If you work hard, you won't be left out."
		},
		"options": [
			{
				"text": {
					"es": "Daré lo mejor de mí para la empresa.",
					"en": "I will give my best for the company."
				},
				"effect": +6
			},
			{
				"text": {
					"es": "Lástima por los nuevos.",
					"en": "Too bad for the new ones."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "No hay problema, pasaré mi carta.",
					"en": "No problem, I'll pass on my letter."
				},
				"effect": -4
			}
			
		]
	},
	{
		"question": {
			"es": "Llegaste tarde hoy. Te descontaremos el día completo.",
			"en": "You were late today. We'll dock the whole day."
		},
		"options": [
			{
				"text": {
					"es": "Es cierto, me lo gané.",
					"en": "That's right, I earned it."
				},
				"effect": +6
			},
			{
				"text": {
					"es": "Tengo un compañero que hizo lo mismo.",
					"en": "I have a colleague who did the same thing."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Lo siento, pero eso no \n justifica el descuento completo.",
					"en": "Sorry, but that doesn't \n justify the full discount."
				},
				"effect": -4
			}
			
		]
	},
	{
		"question": {
			"es": "¿Te molesta si les pagamos un mejor salario a los nuevos?",
			"en": "Do you mind if we pay the new ones a better salary?"
		},
		"options": [
			{
				"text": {
					"es": "Para nada, hay que incentivarlos.",
					"en": "Not at all, they should be encouraged."
				},
				"effect": +5
			},
			{
				"text": {
					"es": "¿Suelen pagar más?",
					"en": "Do you usually pay more?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "En otro lugar me valorarían más.",
					"en": "I would be valued more elsewhere."
				},
				"effect": -3
			}
			
		]
	},
	{
		"question": {
			"es": "El equipo de trabajo es como una familia.",
			"en": "The work team is like a family."
		},
		"options": [
			{
				"text": {
					"es": "¡La familia es primero!",
					"en": "Family comes first!"
				},
				"effect": +8
			},
			{
				"text": {
					"es": "No, gracias.",
					"en": "No, thanks."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Una familia que te \n apuñala por la espalda.",
					"en": "A family that stabs \n you in the back."
				},
				"effect": -6
			},
			
			
		]
	},
	{
		"question": {
			"es": "Puede que no ofrezcamos mucho aquí, pero somos felices.",
			"en": "We may not offer much here, but we're happy."
		},
		"options": [
			{
				"text": {
					"es": "Ustedes son todo para mí.",
					"en": "You are everything to me."
				},
				"effect": +10
			},
			{
				"text": {
					"es": "Al menos tienen razón en algo.",
					"en": "At least you're right about something."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "De felicidad no vivo.",
					"en": "I don't live on happiness."
				},
				"effect": -6
			},
			
			
		]
	},
	{
		"question": {
			"es": "Recuerda que trabajas por pasión, no por dinero.",
			"en": "Remember that you work for passion, not for money."
		},
		"options": [
			{
				"text": {
					"es": "El dinero es lo último que pensaría",
					"en": "Money is the last thing I would think about."
				},
				"effect": +7
			},
			{
				"text": {
					"es": "Creo que me está dando hambre.",
					"en": "I think I'm getting hungry."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Recuerda que eres un jefe, \n no un esclavista",
					"en": "Remember that you are a boss, \n not a slave owner."
				},
				"effect": -5
			},
			
			
		]
	},
	{
		"question": {
			"es": "Si no vienes sábado, no hace falta que vengas el lunes.",
			"en": "If you don't come on Saturday, you don't need to come on Monday."
		},
		"options": [
			{
				"text": {
					"es": "Jamás los dejaría abandonados.",
					"en": "I would never leave you abandoned."
				},
				"effect": +5
			},
			{
				"text": {
					"es": "Sería una lástima quedarme dormido.",
					"en": "It would be a shame to fall asleep."
				},
				"effect": 0
			},
			{
				"text": {
					"es": "No vale la pena desperdiciar \n mi único día de descanso.",
					"en": "It's not worth wasting \n my only day off."
				},
				"effect": -3
			},
			
			
		]
	},
	{
		"question": {
			"es": "Solo puedes recibir vacaciones cuando estés despedido.",
			"en": "You can only receive vacation pay when you are fired."
		},
		"options": [
			{
				"text": {
					"es": "No me gustan las vacaciones.",
					"en": "I don't like vacations."
				},
				"effect": +5
			},
			{
				"text": {
					"es": "¿También me quitarán los fines de semana?",
					"en": "Will you also take away my weekends?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Tendré que escoger entre carta a \n recursos humanos o carta de renuncia.",
					"en": "I'll have to choose between a letter \n to human resources or a resignation letter."
				},
				"effect": -3
			},
			
			
		]
	},
	{
		"question": {
			"es": "Trabajar 16 horas al día aumenta la productividad. ¿Estás de acuerdo?",
			"en": "Working 16 hours a day increases productivity. Do you agree?"
		},
		"options": [
			{
				"text": {
					"es": "Claro, dormir es para los débiles.",
					"en": "Of course, sleep is for the weak."
				},
				"effect": +6
			},
			{
				"text": {
					"es": "¿Puedo dormir bajo el escritorio?",
					"en": "Can I sleep under the desk?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Prefiero ser reemplazado por un robot.",
					"en": "I'd rather be replaced by a robot."
				},
				"effect": -4
			},
			
			
		]
	},
	{
		"question": {
			"es": "Antes de renunciar, debes entrenar a tu reemplazo.",
			"en": "Before you resign, you must train your replacement."
		},
		"options": [
			{
				"text": {
					"es": "Nunca me verán renunciar",
					"en": "You will never see me quit"
				},
				"effect": +4
			},
			{
				"text": {
					"es": "¿Acaso contratan tontos?",
					"en": "Do you hire fools?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Es su problema, el mío es salir de aquí",
					"en": "It's your problem, mine is getting out of here."
				},
				"effect": -2
			},
			
			
		]
	},
	{
		"question": {
			"es": "Si estás enfermo por más de dos días, no se te pagará",
			"en": "If you are sick for more than two days, you will not be paid."
		},
		"options": [
			{
				"text": {
					"es": "¡Estoy hecho de titanio!",
					"en": "I'm made of titanium!"
				},
				"effect": +5
			},
			{
				"text": {
					"es": "¿Y si es el jefe quien se enferma?",
					"en": "What if it's the boss who gets sick?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "¿Me atarán con grilletes al hospital?",
					"en": "Will I be shackled in the hospital?"
				},
				"effect": -3
			},
			
			
		]
	},
	{
		"question": {
			"es": "El jefe revisará tus mensajes privados para 'optimizar tu comunicación'.",
			"en": "The boss will review your private messages to 'optimize communication'."
		},
		"options": [
			{
				"text": {
					"es": "No tengo vida social, así que adelante.",
					"en": "I have no social life, so go ahead."
				},
				"effect": +7
			},
			{
				"text": {
					"es": "¿Puedo venderles mis datos personales?" ,
					"en": "Can I sell you my personal data?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "Puede que no les guste lo que encuentren...",
					"en": "You may not like what you find..."
				},
				"effect": -5
			},
			
			
		]
	},
	{
		"question": {
			"es": "Si trabajas horas extras, te daremos un 'gracias' en Comic Sans.",
			"en": "If you work overtime, you’ll get a 'thank you' in Comic Sans."
		},
		"options": [
			{
				"text": {
					"es": "Comic Sans es mi lenguaje de amor.",
					"en": "Comic Sans is my love language."
				},
				"effect": +5
			},
			{
				"text": {
					"es": "¿Puedo canjearlo por una palmada en la espalda?" ,
					"en": "Can I redeem it for a pat on the back?"
				},
				"effect": 0
			},
			{
				"text": {
					"es": "-Esta opción ha sido censurada por RRHH-" ,
					"en": "-This option has been censored by HR-"
				},
				"effect": -3
			},
			
			
		]
	}
	
]
