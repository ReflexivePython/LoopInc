extends Node2D

@onready var decoration = $deco
@onready var floor_tilemap = $floor

func _ready() -> void:
	if Day.day > 4:
		change_room_state(Vector2(3,3),2)
		change_room_state(Vector2(12,5),4)
		
		change_floor_state()

func change_room_state(pos,tile_id):
	decoration.set_cell(pos,tile_id,Vector2i.ZERO)

func change_floor_state():
	var used_cells = floor_tilemap.get_used_cells()
	
	for cell in used_cells:
		floor_tilemap.set_cell(cell,0,Vector2i.ZERO)
