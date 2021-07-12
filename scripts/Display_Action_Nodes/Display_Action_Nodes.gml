/// @function		Display_Action_Nodes(node_start, range, impassable_allowed, actors_block, list_of_active_nodes)
/// @desc			Generate a node_current_neigbours that contains all the nodes that can be used for mouvement, attacking...
/// @param			node_start {real}				The instance_id of the node_current_neigbours that we want to calculate from (eg caracter pos for movement, attack landing for AOE)
/// @param			range {real}					The distance from the node_start that we want to check for nodes to add to node_current_neigbours
/// @param			impassable_allowed {boolean}	add impassable nodes ?
/// @param			actors_block {boolean}			Does other actors block ?
/// @param			list_of_active_nodes {real}		Index of the node_current_neigbours that will store the instance_id of active nodes
/// @param
function Display_Action_Nodes(){
	
	var node_start				= argument[0];
	var range					= argument[1];
	var impassable_allowed		= argument[2];
	var actors_block			= argument[3];
	var list_of_active_nodes	= argument[4];
	var terrain_cost			= 1;
	
	var nodes_open				= ds_priority_create();
	var added_to_open_already	= ds_list_create();
	ds_list_clear(list_of_active_nodes);
	
	with (oNode) {
		combined_distance = 0;
		parent = noone;
	}
	
	//node_start.combined_distance = 0;
	
	//On met la node de départ dans les nodes_open
	ds_priority_add(nodes_open, node_start, node_start.combined_distance);
	
	//var node_current = noone;
	
	while (ds_priority_size(nodes_open) > 0) {
		
		//On sort la node la plus proche des nodes_open... (1st time c'est la node_start)
		var node_current = ds_priority_delete_min(nodes_open);
		//...et on la met dans les nodes déjà open
		ds_list_add(added_to_open_already, node_current);
			
		//Si une node n'est pas du vide ?
		if (node_current != undefined) {
			
			// On prend les neigbours de la node
			var node_current_neigbours = node_current.neigbours;
			
			for (var i = 0; i < array_length(node_current_neigbours); i++) {
				var node_current_neigbours = node_current_neigbours[i];
					
				// Si on trouve la node neigbour dans les nodes déjà open	
				if (ds_list_find_index(added_to_open_already, node_current_neigbours) != -1) {	
					// si les neigbours sont plus loin que la node
					if (node_current.combined_distance + terrain_cost < node_current_neigbours.combined_distance) {
						// la node devient le parent des neigbours
						node_current_neigbours.parent = node_current;
						// on prévient que les neigbours sont plus loins de 1 que la node
						node_current_neigbours.combined_distance = node_current.combined_distance + 1;
					}
				}
				// Si on trouve pas la node neigbour dans les nodes déjà open
				else {	
					// la node devient le parent des neigbours
					node_current_neigbours.parent = node_current;
					// si on peut pas la passer on la met dans les nodes déjà open
					if (node_current_neigbours.passable == false && impassable_allowed == false)	
						ds_list_add(added_to_open_already, node_current_neigbours);	
						
					//if (actors_block && actor_grid[# node_current_neigbours.grid_x, node_current_neigbours.grid_y] != noone)	
					//	ds_list_add(added_to_open_already, node_current_neigbours);
					
					// Si on trouve pas la node neigbour dans les nodes déjà open
					if (ds_list_find_index(added_to_open_already, node_current_neigbours) == -1) {
						// la neigbour est plus loin de la node de 1
						node_current_neigbours.combined_distance = terrain_cost + node_current.combined_distance;
						//si la neigbour est dans la range max
						if (node_current_neigbours.combined_distance <= range) {
							// on la rajoute dans les nodes open avec sa distance 
							ds_priority_add(nodes_open, node_current_neigbours, node_current_neigbours.combined_distance);
							// et dans les nodes déjà open
							ds_list_add(added_to_open_already, node_current_neigbours);
						}
					}
				}
					
			}
			ds_list_add(list_of_active_nodes, node_current);
		}
		else break;
	}
	
	ds_list_destroy(added_to_open_already);
	ds_priority_destroy(nodes_open);
}