

		
// On check toutes les tiles...
for (var yy = 0; yy < rows; yy++) {
for (var xx = 0; xx < columns; xx++) {
		
	var tile = tiles[# xx, yy];
	draw	= TilePosToScreen(xx, yy);
	draw_x	= draw[0]; 
	draw_y	= draw[1];
	
		
#region		Draw tile
	with (tile)		draw_sprite(sprite, image_index, x, y);
#endregion

#region		Placing
if (current_turn_state == TURN_STATE.PLACING) {

	//previsualization placement
	if (grid_without_clamp_x == grid_x 
	&& grid_without_clamp_y == grid_y
	&& grid_x == xx 
	&& grid_y == yy)	{
			draw_sprite_ext(global.sprites_units[tile.side], 0, draw_x, draw_y, 1, 1, 0, c_white, 0.5);
	}

}
#endregion

#region		Actions
	if (current_turn_state == TURN_STATE.ACTIONS) {
	
	#region		Draw Nodes
		var node = nodes[# xx, yy];
		if (ds_list_find_index(list_of_active_nodes, node) != -1) {
			with (node) {
				draw_sprite(spNode, 0, x, y) ;
				draw_text(x, y, string(node.distance));
			}
		}
	#endregion
	
	}
#endregion
	
#region		Draw Cursor
		if (xx == grid[0] && yy == grid[1])		draw_sprite(spCursor, 0, draw[0], draw[1]);	
#endregion	
	
}
}

