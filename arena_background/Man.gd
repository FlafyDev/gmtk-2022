extends Sprite

export(bool) var hop = false;

var time = 0;


func _physics_process(delta):
	time += delta;
	if (hop):
		offset.y = -abs(sin(time * 20) * 5);
	else:
		offset.y = 0;
