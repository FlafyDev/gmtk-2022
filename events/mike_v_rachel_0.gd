extends Node;

func event(next_turn, sum, winner_name, left_player, right_player):
	if (winner_name != null):
		return [
			["man_in"],
			["dialogue", [
				["Mike's friend",
				"Mike! Mike, there you are! Me and the guys were looking everywhere for you!"],
				["Mike",
				"Yo wazzap maaan? Look, look, Imma 'bout to beat those suckers up!"],
				["Mike", "..."],
				["Mike", "No offense Rachel."],
				["Mike's friend",
				"Mike, we’ve got no time for that."],
				["Mike's friend",
				"your wedding’s in a few hours, you need to go get some sleep."],
				["Mike", "Nah man, it's not gonna take long, I promise."],
				["Rachel", ".......?"],
				["Mike", "What?"],
				["Rachel", "You're getting MARRIED?!"],
				["Mike", "Uhhh..."],
				["Rachel", "You asshole!"],
			]],
			["rachel_slap"]
		];
	
	
