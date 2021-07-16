#region		Selection option

if (keyboard_check_pressed(vk_up))		option_targeted--;
if (keyboard_check_pressed(vk_down))	option_targeted++;

if (option_targeted >= ds_grid_height(fightMenu))	option_targeted = 0;
if (option_targeted < 0)							option_targeted = ds_grid_height(fightMenu)-1;


if (keyboard_check_pressed(vk_enter)) {
	option_selected = fightMenu[# FIGHTMENU_COLUMNS.FUNCTION, option_targeted];
}

#endregion

mouse_grid_x = oTilesController.mouse_grid_x;
mouse_grid_y = oTilesController.mouse_grid_y;

switch (option_selected) {

#region		Move
	case FIGHTMENU_OPTIONS.MOVE:
		var node_start		= nodes[# tile_selected.grid_x, tile_selected.grid_y];
		Set_Active_Nodes(node_start, 1, true, false, active_nodes);
		
		if (mouse_check_button_pressed(mb_left)) {
			var node_move		= nodes[# mouse_grid_x, mouse_grid_y];
			show_debug_message("move");
			
			if (ds_list_find_index(active_nodes, node_move)) {
				var tile_move	= oTilesController.tiles[# mouse_grid_x, mouse_grid_y];
				var unit_moving = tile_selected.unit;
				
				with (tile_selected) {
					unit = noone;	
				}
				
				with (tile_move) {
					unit = unit_moving;
				}
			
				unit_moving = {
					grid_x	: mouse_grid_x,
					grid_y	: mouse_grid_y
				};
				
				Quit_FightMenu();
			}
			else {
				Quit_FightMenu();
			}
		}
	break;
	
#endregion

#region		Attack
	case FIGHTMENU_OPTIONS.ATTACK:
		var node_start		= nodes[# tile_selected.grid_x, tile_selected.grid_y];
		Set_Active_Nodes(node_start, 5, true, true, active_nodes);
		
		if (mouse_check_button_pressed(mb_left)) {
			var node_attacked = nodes[# mouse_grid_x, mouse_grid_y];
		
			if (ds_list_find_index(active_nodes, node_attacked)) {
				var tile_attacked = oTilesController.tiles[# mouse_grid_x, mouse_grid_y];
				
				if (tile_attacked.unit != noone)	{
					delete tile_attacked.unit;
					tile_attacked.unit = noone;
					Quit_FightMenu();
				}
			}
			else {
				Quit_FightMenu();
			}
		}
		break;
}
#endregion


