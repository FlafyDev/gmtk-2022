func event(next_turn, sum, winner_name, left_player, right_player):
	if (winner_name == "Rachel"):
		return ["dialogue", [
			["Mike", "Ahh nooo waay I lost to you, Rachel!"]
		]];
	if (winner_name == "Mike"):
		return ["dialogue", [
			["Rachel", "Can't believe I lost."],
			["Rachel", "You're lucky, Mike!"],
		]];
	
	
