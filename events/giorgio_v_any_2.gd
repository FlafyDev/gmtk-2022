extends Node

var turn = -1;
func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (turn == 0):
		return [
			["open_gang"]
		];

	if (winner_name != null):
		return [
			["dialogue", [
				["Giorgio", "Ok, I gotta go."],
				["Giorgio", "I got some business to take care of."],
			]]
		];
