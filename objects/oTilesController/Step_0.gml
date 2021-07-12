
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
	
#region		Toggle placing or actions

if (keyboard_check_pressed(ord("T"))) {
	if (current_turn_state == TURN_STATE.PLACING)	current_turn_state = TURN_STATE.ACTIONS;
	else											current_turn_state = TURN_STATE.PLACING;		
	
}

#endregion

#region		Targeting tile with mouse
grid = ScreenToTilePos(mouse_x, mouse_y);
grid_x = grid[0];
grid_y = grid[1];
grid_without_clamp_x = grid[2];
grid_without_clamp_y = grid[3];
#endregion 

#region		Placing
if (current_turn_state == TURN_STATE.PLACING) {

	#region		When left clic -> Change tile's data
	if (mouse_check_button_pressed(mb_left) 
	// Si on vise le board
	&& grid_without_clamp_x == grid_x
	&& grid_without_clamp_y == grid_y) {

		var tile = tiles[# grid_x, grid_y];
		
		var unit_init = instance_create_layer(tile.x, tile.y, "Units", oUnit)
		with (unit_init) {
			var tile = other.tiles[# other.grid_x, other.grid_y];
			
			sprite_index	= global.sprites_units[tile.side];
			image_index		= 0;
			grid_x			= other.grid_x;
			grid_y			= other.grid_y; 
			side			= tile.side;
			
		}
		tile.unit = unit_init;
	}
	#endregion
}
#endregion

#region		Actions
if (current_turn_state == TURN_STATE.ACTIONS) {
	
	if (mouse_check_button_pressed(mb_left) 
	// Si on vise le board
	&& grid_without_clamp_x == grid_x
	&& grid_without_clamp_y == grid_y) {

		var tile = tiles[# grid_x, grid_y];
		var grid_selected_x = grid_x;
		var grid_selected_y = grid_y;
	
	#region		Nodes
	Set_Active_Nodes(nodes[# grid_selected_x, grid_selected_y], 1, true, list_of_active_nodes);
	path_queue = ds_priority_create();
	#endregion
	}
}
#endregion

