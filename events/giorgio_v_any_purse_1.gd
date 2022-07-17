extends Node;

var turn = -1;

func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	var other_player = right_player if left_player == "Giorgio" else left_player;
	
	if (turn == 1):
		return [
			["giorgio_phone_ring"],
			["dialogue", [
				[other_player, "You're not going to answer that?"],
				["Giorgio", "Nah it's just spam."],
			]],
			["rachel_walks_in"],
			["dialogue", [
				["Rachel", "Hey, I think I accidentally left my purse here."],
				["Rachel", "Oh, there it is."],
			]],
			["rachel_walks_out"],
		];
