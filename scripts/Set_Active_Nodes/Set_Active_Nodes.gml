/// @function		Test(node_start, range, impassable_allowed, actors_block, list_of_active_nodes)
/// @desc			Generate a node_current_neigbours that contains all the nodes that can be used for mouvement, attacking...
/// @param			node_start {real}				The instance_id of the node_current_neigbour that we want to calculate from (eg caracter pos for movement, attack landing for AOE)
/// @param			range {real}					The distance from the node_start that we want to check for nodes to add to node_current_neigbours
/// @param			impassable_allowed {boolean}	add impassable nodes ?
/// @param			list_of_active_nodes {real}		Index of the node_current_neigbours that will store the instance_id of active nodes
function Set_Active_Nodes(){
	
	var node_start				= argument[0];
	var range					= argument[1];
	var impassable_allowed		= argument[2];
	var list_of_active_nodes	= argument[3];
	
	var nodes_pending			= ds_priority_create();
	var nodes_checked			= ds_list_create();
	ds_list_clear(list_of_active_nodes);
	
	//with (oNode) {
	//	distance = -1;
	//	parent = noone;
	//}
	
	//On met la node de départ dans les nodes_pending
	node_start.distance = 0;
	ds_priority_add(nodes_pending, node_start, node_start.distance);
	ds_list_add(list_of_active_nodes, node_start);
	ds_list_add(nodes_checked, node_start);
	
	while (ds_priority_size(nodes_pending) > 0) {
		//On sort la node la plus proche des nodes_pending... (1st time c'est la node_start)
		 node_current = ds_priority_delete_min(nodes_pending);
		
		if (node_current.distance < range) {
			// On prend un neigbour
			for ( i = 0; i < array_length(node_current.neigbours); i++) {
				 node_current_neigbour = node_current.neigbours[i];
					
				// Si la neigbour n'est pas encore checké
				if (ds_list_find_index(nodes_checked, node_current_neigbour) == -1) {	
					
					if (	impassable_allowed == false && node_current_neigbour.passable == true
						||	impassable_allowed == true) {
						// || (actors_block && actor_grid[# node_current_neigbour.grid_x, node_current_neigbour.grid_y] != noone)
						// la node devient le parent du neigbour
						node_current_neigbour.parent = node_current;
						// le voisin est + éloigné de 1 que la node
						node_current_neigbour.distance = node_current.distance + 1;
						// on la rajoute dans les nodes actives, pending, checked
						ds_list_add(list_of_active_nodes, node_current_neigbour);
						ds_priority_add(nodes_pending, node_current_neigbour, node_current_neigbour.distance);	
					}
					ds_list_add(nodes_checked, node_current_neigbour);
				}
			}
		}
	}
	ds_list_destroy(nodes_checked);
	ds_priority_destroy(nodes_pending);
}