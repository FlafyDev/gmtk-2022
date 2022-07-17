extends Node

var turn = -1;
func event(next_turn, sum, winner_name, left_player, right_player):
	turn += 1;
	
	if (turn == 0):
		return [
			["open_gang"]
		];
	
	if (winner_name != null):
		if (turn > 5):
			return [
				["dialogue", [
					["Giorgio", "Ok, I gotta go."],
					["Giorgio", "I got some business to take care of."],
					["James", "Hey, hold on!"],
					["James", "The lady told me what you're planning. Stop right where you are!"],
					["Giorgio", "Oh and what are you going to do exactly?"],
				]],
				["james_gun"],
				["dialogue", [
					["James", "Hands up!"],
					["Giorgio", "You think you can stop us by yourself?"],
					["Giorgio", "Come on guys!"],
				]],
				["wait", 2],
				["dialogue", [
					["Giorgio", "..."],
					["Giorgio", "Guys?!"],
				]],
				["gang_arrested"],
				["dialogue", [
					["James", "I called backup, your gang is under our arrest."],
				]],
			];
		else:
			return [
				["dialogue", [
					["Giorgio", "Ok, I gotta go."],
					["Giorgio", "I got some business to take care of."],
					["James", "Hey, hold on!"],
					["James", "The lady told me what you're planning. Stop right where you are!"],
					["Giorgio", "Oh and what are you going to do exactly?"],
				]],
				["james_gun"],
				["dialogue", [
					["James", "Hands up!"],
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
