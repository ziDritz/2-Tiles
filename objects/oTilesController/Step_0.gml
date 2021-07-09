
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

#region		Tiles

	// Création des tiles
	#region		Tile set up
// Init
if (global.code_phase == code.init) {
	// Var/Const
	columns = 8;
	rows = 4;
	tiles = ds_grid_create(columns, rows);

	enum tile_e {
		spawn_character,		//-1 : no spawn, 0 : spawn player, 1 : spawn ennemy
		character,
		last
	}

	// Set up
	for (var yy = 0; yy < rows; yy++) {
		for (var xx = 0; xx < columns; xx++) {
		
			// Each tile is a grid, containing tile_e
			var tile = ds_list_create();
		
			// Init data in tiles
			for (var data = 0; data < tile_e.last; data++) {
				tile[|data] = -1; 
			}
			tiles[# xx, yy] = tile;
		}
	}
}
	#endregion
	
	// On rentre de l'info dans les tiles
	#region		Selecting tile with mouse
grid = ScreenToTilePos(mouse_x, mouse_y);
grid_x = grid[0];
grid_y = grid[1];
grid_without_clamp_x = grid[2];
grid_without_clamp_y = grid[3];
	#endregion 
	
	#region		Character side switch	
// Init
if (global.code_phase == code.init) {
	side_current = 0;
}

// Step
if (keyboard_check_pressed(vk_right)) {
	if (side_current + 1 < side_e.last)		side_current++;
	else									side_current = side_e.player;
}

if (keyboard_check_pressed(vk_left)) {
	if (side_current - 1 >= 0)				side_current--;
	else									side_current = side_e.ennemy;
}
	#endregion

	#region		When left clic -> Change tile's data with switchs
if (mouse_check_button_pressed(mb_left) 
&& grid_without_clamp_x = grid_x
&& grid_without_clamp_y = grid_y) {
	
	var tile = tiles[# grid_x, grid_y];
	
	if (current_turn_state == turn_state.placing)	{
		tile[|tile_e.spawn_character]	= true;
		tile[|tile_e.character]			= side_current;
	}
}
	#endregion

#endregion


