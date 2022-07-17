extends Node;

func event(next_turn, sum, winner_name, left_player, right_player):
	if (winner_name == "Rachel"):
		return ["dialogue", [
			["Mike", "Oh man... I was sure I had it."],
			["Mike", "Oh well, you can do it babe."],
		]];
	if (winner_name == "R"):
		return ["dialogue", [
			["Rachel", "Well, I guess that's not my lucky day, good luck love <3."],
		]];
	
	
