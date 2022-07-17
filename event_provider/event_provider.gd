var previous_matches = [];

func get_event(current_match):
	if (current_match[0] == 0 && current_match[1] == 1 && previous_matches.size() == 0):
		return _eventfunc("mike_v_rachel_0");
	

func _eventfunc(name):
	return funcref(load("res://events/%s.gd" % [name]).new(), "event");
