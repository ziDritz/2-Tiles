/// @desc
	
if (keyboard_check_pressed(ord("F"))) {
	if		(fight_state < FIGHT_STATE.last)	fight_state++;																		
	if		(fight_state >= FIGHT_STATE.last)	fight_state = 0;
}

switch (fight_state) {
	#region		FIGHT_STATE.INIT
	case FIGHT_STATE.INIT:
	//choix step card (récmpense)
	//placement random des keys
	//placement des persos
	break;
	#endregion
	
	#region		FIGHT_STATE.ROUND.
	case FIGHT_STATE.ROUND:
		if (keyboard_check_pressed(ord("T")))	end_turn = true;
		switch (round_state) {
			#region		ROUND_STATE.INIT
			case ROUND_STATE.INIT:
				end_turn		= false
				round_state		= ROUND_STATE.PLAYERS;
			break;
			#endregion
			
			#region		ROUND_STATE.PLAYERS
			case ROUND_STATE.PLAYERS:
				
				//Attack ou se déplacer (oFightMenu)
				//Si player attack -> un ennemy peut attack ET/OU se déplacer (round_state = ROUND_STATE.GM;)	
				if (end_turn == true)	{
					round_state		= ROUND_STATE.GM;
					end_turn		= false
				}
			break;
			#endregion
			
			#region		ROUND_STATE.GM
			case ROUND_STATE.GM:
				//Changement de strat
				//Attack ou se déplacer (oFightMenu)
				if (end_turn == true)	{
					round_state		= ROUND_STATE.INIT;
					end_turn		= false
				}
			break;
			#endregion
		}
	break;
	#endregion
	
	#region		FIGHT_STATE.CHECK_CONDITION
	case FIGHT_STATE.CHECK_CONDITION:
		// Si tout les ennemies sont mort -> gagné
		// Si tout les alliés sont mort -> perdu
		// Si une clé meurt -> perdu
	break;
	#endregion
	
	#region		FIGHT_STATE.END
	case FIGHT_STATE.END:
		// Marchand
	break;
	#endregion
}


