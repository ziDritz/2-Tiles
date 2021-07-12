


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

#endregion

#region		Sprites init
if (global.code_phase == code.init) {
	global.sprites_units = [];
	array_insert(global.sprites_units, SIDE.PLAYER, spPlayer);
	array_insert(global.sprites_units, SIDE.ENNEMY, spEny);
}
#endregion

#region		Toggle placing or actions

enum TURN_STATE {
	PLACING,
	ACTIONS
}
current_turn_state = TURN_STATE.PLACING;

#endregion

#region		Tiles
// Init
	// Var/Const
columns = 8;
rows = 4;
tiles = ds_grid_create(columns, rows);
grid_x = 0;
grid_y = 0;

	// Set up
for (var yy = 0; yy < rows;		yy++) {
for (var xx = 0; xx < columns;	xx++) {
			
	draw	= TilePosToScreen(xx, yy);
	draw_x	= draw[0]; 
	draw_y	= draw[1]; 
	if ( xx <= 3 )	var side_init = SIDE.PLAYER;
	if ( xx > 3 )	var side_init = SIDE.ENNEMY;
		
	var tile_init = {
		x				: draw_x, 
		y				: draw_y, 
		sprite			: spTile,
		image_index	: 1,
		grid_x			: xx, 
		grid_y			: yy, 
		
		side			: side_init,
		unit			: noone,
	};
	tiles[# xx, yy] = tile_init;
}}

	#endregion

#region		Nodes

list_of_active_nodes	= ds_list_create();
nodes					= ds_grid_create(columns, rows);

	// Set up
for (var yy = 0; yy < rows;		yy++) {
for (var xx = 0; xx < columns;	xx++) {	

	draw = TilePosToScreen(xx, yy);
	draw_x = draw[0]; 
	draw_y = draw[1]; 
	var node = {
		x			: draw_x,
		y			: draw_y,
		grid_x		: xx,	
		grid_y		: yy,	
		parent		: noone,
		passable	: true,
		neigbours	: [],
		distance	: -1
	}
	
	//var node = instance_create_layer(draw_x, draw_y, "Nodes", oNode)
	//with (node) {
	//	grid_x = xx;	
	//	grid_y = yy;	
	//	parent = noone;
	//	passable = true;
	//	neigbours = [];
	//}
	nodes[# xx, yy] = node;
	
}}

	// Nodes' Neigbors
for (var yy = 0; yy < rows;		yy++) {		
for (var xx = 0; xx < columns;	xx++) {
	node = nodes[# xx, yy];
	var node_neigbour = nodes[# xx+1, yy];
	if (node_neigbour != undefined)						array_push(node.neigbours, node_neigbour);
	node_neigbour = nodes[# xx-1, yy];
	if (node_neigbour != undefined)						array_push(node.neigbours, node_neigbour);
	node_neigbour = nodes[# xx, yy + 1];
	if (node_neigbour != undefined)						array_push(node.neigbours, node_neigbour);
	node_neigbour = nodes[# xx, yy - 1];
	if (node_neigbour != undefined)						array_push(node.neigbours, node_neigbour);
}}


#endregion

#region		Units

	#region		Side	
		enum SIDE {
			PLAYER,
			ENNEMY
		}
	#endregion
	
#endregion




