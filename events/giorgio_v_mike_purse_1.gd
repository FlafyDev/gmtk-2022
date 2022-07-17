extends Node;

var turn = -1;

func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (turn == 1):
		return [
			["giorgio_phone_ring"],
			["giorgio_phone"],
			["rachel_walks_in"],
			["dialogue", [
				["Giorgio",
				"Yes, yes, path is clear, the guards left their post, you can get in."],
				["Giorgio", "K, gotta go, I don't want no unnecessary attention."],
			]],
			["rachel_walks_out"],
			["dialogue", [
				["Giorgio", "Bye."],
			]],
			["giorgio_no_phone"],
		];
