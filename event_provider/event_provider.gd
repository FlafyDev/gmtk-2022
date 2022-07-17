var previous_matches = [];
var current_match;

var flag_forgot_purse = false;

func _is_match_of(player_ids):
	return current_match[0] in player_ids && current_match[1] in player_ids;

func get_events(current_match):
	self.current_match = current_match;
	var turn = previous_matches.size();
	
	if _is_match_of([0, 1]):
		if (turn == 0):
			flag_forgot_purse = true;
			return _ef("mike_v_rachel_0");
		else:
			return _ef("mike_v_rachel_1_2");
	elif _is_match_of([0]):
		if (turn == 0):
			return _ef("mike_v_any_0");
	else:
		return _ef("generic_0");
	
	if (turn == 1):
		if _is_match_of([3, 0]):
			if flag_forgot_purse:
				return _ef("girogio_v_mike_purse_1");
			else:
				return _ef("girogio_v_mike_1");
		elif _is_match_of([3]):
			if flag_forgot_purse:
				return _ef("girogio_v_any_purse_1");
			else:
				return _ef("girogio_v_any_1");
		else:
			if flag_forgot_purse:
				return _ef("generic_purse_1");
			else:
				pass;
				# return _ef("generic_1");

func _ef(name):
	return funcref(load("res://events/%s.gd" % [name]).new(), "event");
