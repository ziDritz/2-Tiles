
#region		Sprites init
if (global.code_phase == code.init) {
	sprites_character = ds_list_create();
	sprites_character[| SIDE.PLAYER] = spPlayer;
	sprites_character[| SIDE.ENNEMY] = spEny;
}
#endregion
		
// On check toutes les tiles...
for (var yy = 0; yy < rows; yy++) {
	for (var xx = 0; xx < columns; xx++) {
		
		// ... et on sort les infos
		var tile = tiles[# xx, yy];
		class		= tile.class;
		side		= tile.side;
		
		// Position en pixel du draw
		draw = TilePosToScreen(xx, yy);
				draw_x = draw[0]; 
				draw_y = draw[1]; 
		
#region		Draw Cells
		draw_sprite(spTile, 1, draw_x, draw_y);
#endregion

#region		Draw Cursor
		if (xx == grid[0] && yy == grid[1])		draw_sprite(spCursor, 0, draw[0], draw[1]);	
#endregion

#region		Draw Character

		//Character
		if (class > -1)	{				
			draw_sprite(sprites_character[| tile.side], 0, draw_x, draw_y)
		}
			
		//previsualization placement
		if (grid_without_clamp_x = grid_x && grid_without_clamp_y = grid_y
			&& grid_x = xx && grid_y = yy)	{
				draw_sprite_ext(sprites_character[| side_current], 0, draw_x, draw_y, 1, 1, 0, c_white, 0.5);
			}

#endregion
		
	}
}

