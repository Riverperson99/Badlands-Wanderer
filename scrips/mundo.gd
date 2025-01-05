extends Node2D


@onready var tile_map: TileMap = $TileMap

const layer_wather = 0
const layer_ground = 1
const layer_cliffs = 2
const layer_enviroment = 3


var can_place_seed_custom_data: String = "can_place_seed"
var can_place_dirt_custom_data: String = "can_place_dirt"

enum FARMING_MODE {SEEDS, DIRT}
var farming_mode_state= FARMING_MODE.DIRT

var dirt_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("angle_dirt"):
		farming_mode_state = FARMING_MODE.DIRT
	if Input.is_action_just_pressed("angle_seeds"):
		farming_mode_state = FARMING_MODE.SEEDS
	if Input.is_action_just_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		var source_id: int = 0
		
		
		var tile_data: TileData = tile_map.get_cell_tile_data(layer_ground,tile_mouse_pos)
		
		if farming_mode_state == FARMING_MODE.SEEDS:
			var atlas_coord : Vector2i = Vector2i(11,1)
			if retriving_custom_data(tile_mouse_pos, can_place_seed_custom_data, layer_ground):
				tile_map.set_cell(layer_enviroment, tile_mouse_pos, source_id, atlas_coord)
		elif farming_mode_state == FARMING_MODE.DIRT:
			if retriving_custom_data(tile_mouse_pos, can_place_dirt_custom_data, layer_ground):
				dirt_tiles.append(tile_mouse_pos)
				tile_map.set_cells_terrain_connect(layer_ground,dirt_tiles,2,0)
		
		
			
func retriving_custom_data(tile_mouse_pos, custom_data_layer, layer):
	var tile_data: TileData = tile_map.get_cell_tile_data(layer,tile_mouse_pos)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false
	
				
		
