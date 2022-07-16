extends Label


func _ready():
	pass # Replace with function body.

func set_selected(selected: bool):
	set("custom_colors/font_outline_modulate", \
		Color(0.58, 0.58, 0, 1) if selected else Color.transparent);

func set_out(out: bool):
	set("custom_colors/font_color", \
		Color(1, 1, 1, 0.5) if out else Color.white);
