
#region		Code phases

enum code {
	init,
	step
}

global.code_phase = code.init;

#endregion 

#region		Variables

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
#macro isom_width sprite_get_width(spIsomRef)
#macro isom_height sprite_get_height(spIsomRef)
grid_x = 0;
grid_y = 0;

#endregion

#region		Placing characters or actions

// Placing characters

enum turn_state {
	placing,
	actions
}

current_turn_state = turn_state.placing;

#endregion


