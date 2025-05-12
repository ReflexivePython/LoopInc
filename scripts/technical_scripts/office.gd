extends Node2D


@onready var door = $door
@onready var freedoom = $the_freedoom
@onready var decoration = $decoration
@onready var walls = $walls
@onready var pc = $Area2D

func _ready() -> void:
	if Day.day < 7:
		disable_node(freedoom)
		
	else:
		disable_node(door)
		pc.monitoring = false
		#Set up callendars
		change_callendars()
		
		change_tile(decoration,Vector2(4,10),10)
		change_tile(decoration, Vector2i(29,7),12)
		
		#Changes the window
		change_tile(walls, Vector2(3,-20),4)
		
		change_mc_cubicle()

func disable_node(node):
	node.visible = false
	node.monitorable = false
	node.monitoring = false

func change_callendars():
	var calendars = decoration.get_used_cells_by_id(0)
	
	for i in calendars:
		decoration.set_cell(i,9,Vector2i.ZERO)

func change_tile(tilemap,cell_coords: Vector2i, new_tile_id: int):
	tilemap.set_cell(cell_coords,new_tile_id,Vector2i.ZERO)

func change_mc_cubicle():
	change_tile(decoration, Vector2(8,-13),17)
	change_tile(decoration, Vector2(10,-12),14)
	change_tile(decoration, Vector2(9,-10),14)
	change_tile(decoration, Vector2(10,-11),15)
