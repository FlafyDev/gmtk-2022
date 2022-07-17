extends Node;

var turn = -1;

func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (turn == 1):
		return [
			["rachel_walks_in"],
			["dialogue", [
				["Rachel", "Hey, I think I accidentally left my purse here."],
				["Rachel", "Oh, there it is."],
			]],
			["rachel_walks_out"],
		];
