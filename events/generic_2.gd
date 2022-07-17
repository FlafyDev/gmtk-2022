extends Node

var turn = -1;
func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (turn == 0):
		return [
			["open_gang"]
		];
