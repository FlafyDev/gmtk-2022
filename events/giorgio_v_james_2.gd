extends Node

var turn = -1;
func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (winner_name != null):
		if (turn > 5):
			return [];
		else:
			return [
				["dialogue", [
					["James", "Hey, hold on!"],
					["James", "I know exactly what you're planning. Stop right where you are!"],
					["Giorgio", "Oh and what are you going to do exactly?"],
				]],
				["james_gun"],
				["dialogue", [
					["Giorgio", "You think you can stop us by yourself?"],
					["Giorgio", "Come on guys!"],
				]],
				["gang_in_and_out"],
				["dialogue", [
					["James", "If only I could stall him for a little longer..."],
				]],
			];
	
	elif (turn == 5):
		return [
			["open_agents"]
		];
