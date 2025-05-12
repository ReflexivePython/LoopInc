extends Control

#Language
@onready var language = $language_settings
@onready var eng_button = $language_settings/english
@onready var spa_button = $language_settings/spanish

#Movement
@onready var movement = $movement
@onready var wasd = $movement/wasd
@onready var arrows = $movement/arrows

#Mute
@onready var mute_label = $mute
@onready var accept = $mute/yes

@onready var return_button = $return


func _ready() -> void:
	if Config.is_android:
		movement.visible = false
	
	change_text_language()
	set_mute_text()
	
	#Language
	eng_button.pressed.connect(change_to_en)
	spa_button.pressed.connect(change_to_es)
	
	#Movement
	wasd.pressed.connect(set_wasd)
	arrows.pressed.connect(set_arrows)
	
	#Mute
	accept.pressed.connect(enable_mute)
	
	return_button.pressed.connect(close_settings)


#Language functions
func change_to_es():
	Config.current_language = "es"
	change_text_language()
	Save.save_game()

func change_to_en():
	Config.current_language = "en"
	change_text_language()
	Save.save_game()


#Movement functions
func set_wasd():
	Config.movement_type = "WASD"
	Save.save_game()

func set_arrows():
	Config.movement_type = "ARROWS"
	Save.save_game()

#Mute function
func enable_mute():
	Config.muted = !Config.muted
	set_mute_text()
	Save.save_game()

func set_mute_text():
	if Config.muted:
		if Config.current_language == "en":
			accept.text = "Enabled"
		else:
			accept.text = "Habilitado"
	else:
		if Config.current_language == "en":
			accept.text = "Disabled"
		else:
			accept.text = "Deshabilitado"

#Menu

func close_settings():
	self.get_parent().get_tree().reload_current_scene()
	Save.load_game()
	queue_free()

func change_text_language():
	if Config.current_language == "en":
		#Language
		language.text = "Language"
		eng_button.text = "English"
		spa_button.text = "Spanish"
		
		#Movement
		movement.text = "Movement Input"
		wasd.text = "WASD Keys"
		arrows.text = "Arrow Keys"
		
		#Mute
		mute_label.text = "Mute"
		
		return_button.text = "Return"
	else:
		#Language
		language.text = "Idioma"
		eng_button.text = "Inglés"
		spa_button.text = "Español"
		
		#Movement
		movement.text = "Tipo de movimiento"
		wasd.text = "Teclas WASD"
		arrows.text = "Teclas de Flechas"
		
		#Mute
		mute_label.text = "Mute"
		
		return_button.text = "Volver"
