
switch(global.code_phase) {
	case code.init:
		debug[2] = "side_current: " + string(oTilesController.side_current);
		debug[1] = "grid_x: " + string(oTilesController.grid_x);
		debug[0] = "grid_y: " + string(oTilesController.grid_y);
		debug_count = array_length(debug)

		item_height = font_get_size(fDefault);
		debug_x = 0;
		debug_y = item_height * (debug_count-1) * 1.5;	//position du bas du texte								
		draw_set_font(fDefault)
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	break;
	
	case code.step:
		for (var i = debug_count-1; i >= 0; i--){
			var txt = debug[i];
			var xx = debug_x
			var yy = debug_y - (item_height * i * 1.5);	//interligne de 0.5
			draw_text(xx, yy, txt);
		}
	break;
}
