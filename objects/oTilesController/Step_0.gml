
#region		Camera
// Init
if (global.code_phase == code.init) {
	camera_x = (isom_width / 2) - (camera_get_view_width(view_camera[0]) / 2);
	camera_y = -(camera_get_view_width(view_camera[0]) / 4);
}
	
// Step
if (keyboard_check(ord("Q"))) camera_x -=5;
if (keyboard_check(ord("D"))) camera_x +=5;
if (keyboard_check(ord("Z"))) camera_y -=5;
if (keyboard_check(ord("S"))) camera_y +=5;
camera_set_view_pos(view_camera[0], camera_x, camera_y);
#endregion
	
#region		Targeting tile with mouse
mouse_grid					= ScreenToTilePos(mouse_x, mouse_y);
mouse_grid_x				= mouse_grid[0];
mouse_grid_y				= mouse_grid[1];
mouse_grid_without_clamp_x	= mouse_grid[2];
mouse_grid_without_clamp_y	= mouse_grid[3];
tile_targetted				= tiles[# mouse_grid_x, mouse_grid_y];
#endregion 

switch (oFightStateController.fight_state) {
	case FIGHT_STATE.INIT:
	//choix step card (récmpense)
	//placement random des keys
	//placement des persos
	#region		Placing
	
		if (mouse_check_button_pressed(mb_left) 
		// Si on vise le board
		&& mouse_grid_without_clamp_x == mouse_grid_x
		&& mouse_grid_without_clamp_y == mouse_grid_y) {

			var tile		= tiles[# mouse_grid_x, mouse_grid_y];
			// Instance init
			var unit_init = {
				sprite_index	: global.sprites_units[tile.side],
				image_index		: 0,
				side			: tile.side
			};
			tile.unit = unit_init;			
		}
	#endregion
	break;
	
	
	case FIGHT_STATE.ROUND:
		switch (oFightStateController.round_state) {
			#region		ROUND_STATE.INIT
			case ROUND_STATE.INIT:
			break;
			#endregion
			
			#region		ROUND_STATE.PLAYERS			
			case ROUND_STATE.PLAYERS:
				if (mouse_check_button_pressed(mb_left)) {
				// Selecting Tile with a unit who performs action
					if (is_tile_selected == false) 
					&& (tile_targetted.unit != noone) 
					&& (tile_targetted.unit.side == SIDE.PLAYER) {
						is_tile_selected = true;
						with (instance_create_depth(0, 0, -10, oFightMenu))	{ 
							tile_selected	= other.tiles[# other.mouse_grid_x, other.mouse_grid_y];
						}
					}
				}
			break;
			#endregion
			
			#region		ROUND_STATE.GM
			case ROUND_STATE.GM:
				if (mouse_check_button_pressed(mb_left)) {
				// Selecting Tile with a unit who performs action
					if (is_tile_selected == false) 
					&& (tile_targetted.unit != noone) 
					&& (tile_targetted.unit.side == SIDE.GM) {
						is_tile_selected = true;
						with (instance_create_depth(0, 0, -10, oFightMenu))	{ 
							tile_selected	= other.tiles[# other.mouse_grid_x, other.mouse_grid_y];
						}
					}
				}
			break;
			#endregion
		}
	break;

}



