extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var darkness = $ColorRect

@export var speed: float = 120.0  # Velocidad del personaje

#Buttons
@onready var button_layer = $Buttons
@onready var up = $Buttons/UP
@onready var down = $Buttons/DOWN
@onready var left = $Buttons/LEFT
@onready var right = $Buttons/RIGHT
@onready var interact_button = $Buttons/E
@onready var settings = $Buttons/RETURN

var touch_direction := Vector2.ZERO

var movement = Config.movement_type

func _ready() -> void:
	if Config.is_android:
		button_layer.visible = true
	connect_signals()
	
	if Day.day == 7:
		speed = 120.0
		darkness.modulate.a = 0
	elif Day.day > 4:
		speed = 90.0
		darkness.modulate.a = 0.4


func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Config.is_android:
		direction = touch_direction
	
	elif movement == "WASD":
		direction.x = Input.get_action_strength("D") - Input.get_action_strength("A")
		direction.y = Input.get_action_strength("S") - Input.get_action_strength("W")
	else:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if direction.length() > 0:
		direction = direction.normalized()
		sprite.play("new_walk")
	elif direction.length() == 0:
		sprite.play("idle")
		
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

	velocity = direction * speed
	move_and_slide()


func button_left_pressed():
	touch_direction.x = -1

func button_left_released():
	if touch_direction.x == -1:
		touch_direction.x = 0

func button_right_pressed():
	touch_direction.x = +1

func button_right_released():
	if touch_direction.x == +1:
		touch_direction.x = 0

func button_up_pressed():
	touch_direction.y = -1

func button_up_released():
	if touch_direction.y == -1:
		touch_direction.y = 0

func button_down_pressed():
	touch_direction.y = +1

func button_down_released():
	if touch_direction.y == +1:
		touch_direction.y = 0

func connect_signals():
	up.button_down.connect(button_up_pressed)
	up.button_up.connect(button_up_released)
	
	down.button_down.connect(button_down_pressed)
	down.button_up.connect(button_down_released)
	
	left.button_down.connect(button_left_pressed)
	left.button_up.connect(button_left_released)
	
	right.button_down.connect(button_right_pressed)
	right.button_up.connect(button_right_released)
	
	interact_button.pressed.connect(_on_interact_button_pressed)
	settings.pressed.connect(_on_settings_button_pressed)
	

func _on_interact_button_pressed():
	var press_event := InputEventAction.new()
	press_event.action = "E"
	press_event.pressed = true
	Input.parse_input_event(press_event)
	
	await  get_tree().create_timer(0.5).timeout
	
	var release_event := InputEventAction.new()
	release_event.action = "E"
	release_event.pressed = false
	Input.parse_input_event(release_event)

func _on_settings_button_pressed():
	var press_event := InputEventAction.new()
	press_event.action = "ui_cancel"
	press_event.pressed = true
	Input.parse_input_event(press_event)
	
	await  get_tree().create_timer(0.5).timeout
	
	var release_event := InputEventAction.new()
	release_event.action = "ui_cancel"
	release_event.pressed = false
	Input.parse_input_event(release_event)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		show_config_menu()

func show_config_menu():
	Save.save_game()
	var menu_scene = preload("res://scenes/settings.tscn").instantiate()
	var layer = CanvasLayer.new()
	layer.add_child(menu_scene)
	
	add_child(layer)
	
