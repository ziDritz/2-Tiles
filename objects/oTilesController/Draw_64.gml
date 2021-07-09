if (global.code_phase == code.init) {};

#region		Draw Editor

		start_draw_x =	sprite_get_width(spPlayer);
		start_draw_y =	gui_height - sprite_get_height(spPlayer);

		for (var i = 0; i < side_e.last; i++) {
			
			draw_x = start_draw_x + i * sprite_get_width(spPlayer);
			draw_y = start_draw_y - sprite_get_height(spPlayer);
			draw_sprite(sprites[| i], 0, draw_x, draw_y);
			
		}
#endregion
