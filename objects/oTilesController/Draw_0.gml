
#region		Sprites init
if (global.code_phase == code.init) {
	current_sprite = 0;
	sprites = ds_list_create();
	sprites[| side_e.player] = spPlayer;
	sprites[| side_e.ennemy] = spEny;
}
#endregion
		
for (var yy = 0; yy < rows; yy++) {
	for (var xx = 0; xx < columns; xx++) {
		
		draw = TilePosToScreen(xx, yy);
		draw_x = draw[0]; 
		draw_y = draw[1]; 
		
		// On sort l'info des tiles
		var tile = tiles[# xx, yy];
		spawn_tile		= tile[| tile_e.spawn_character];
		character		= tile[| tile_e.character];
			
#region		Draw Cells

		draw_sprite(spTile, 1, draw_x, draw_y);
		
#endregion

#region		Draw Cursor

		if (xx == grid[0] && yy == grid[1])		draw_sprite(spCursor, 0, draw[0], draw[1]);	

#endregion

#region		Draw Character

		//Character
		if (spawn_tile == true)	{				
			switch (character) {
				case side_e.player:
					current_sprite = sprites[| side_e.player];
					break;
				case side_e.ennemy:
					current_sprite = sprites[| side_e.ennemy];
					break;
			}
			draw_sprite(current_sprite, 0, draw_x, draw_y)
		}
			
			
		//Character previsualization placement
		if (grid_without_clamp_x = grid_x && grid_without_clamp_y = grid_y
			&& grid_x = xx && grid_y = yy)	{
				draw_sprite_ext(sprites[| side_current], 0, draw_x, draw_y, 1, 1, 0, c_white, 0.5);
			}

#endregion
		
	}
}

