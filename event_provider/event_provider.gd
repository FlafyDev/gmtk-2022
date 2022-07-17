var previous_matches = [];
var current_match;

var flag_forgot_purse = false;

func _is_match_of(player_ids):
	return player_ids[0] in current_match && player_ids[1] in current_match;

func get_events(current_match):
	self.current_match = current_match;
	var turn = previous_matches.size();
	
	if _is_match_of([0, 1]):
		if (turn == 0):
			flag_forgot_purse = true;
			return _ef("mike_v_rachel_0");
		else:
			return _ef("mike_v_rachel_1_2");
	elif _is_match_of([0, 0]) && turn == 0:
		return _ef("mike_v_any_0");
	elif (turn == 0):
		return _ef("generic_0");
	
	if (turn == 1):
		if _is_match_of([1, 1]):
			flag_forgot_purse = false;
		
		if _is_match_of([3, 0]):
			if flag_forgot_purse:
				return _ef("giorgio_v_mike_purse_1");
			else:
				return _ef("giorgio_v_mike_1");
		elif _is_match_of([3, 3]):
			if flag_forgot_purse:
				return _ef("giorgio_v_any_purse_1");
			else:
				return _ef("giorgio_v_any_1");
		else:
			if flag_forgot_purse:
				return _ef("generic_purse_1");
			else:
				pass;
				# return _ef("generic_1");
	
	if (turn == 2):
		if _is_match_of([3, 2]):
			if flag_forgot_purse:
				return _ef("giorgio_v_james_2");
		elif _is_match_of([3, 3]):
			return _ef("giorgio_v_any_2");
		else:
			return _ef("generic_2");

func _ef(name):
	return funcref(load("res://events/%s.gd" % [name]).new(), "event");
