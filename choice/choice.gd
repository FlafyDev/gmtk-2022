extends Control

signal result(number);

onready var _animation_player = $AnimationPlayer;

var accepting_input = false;
var selected_input = 0;

func _ready():
	visible = false;

func start():
	visible = true;
	accepting_input = false;
	_animation_player.play("in")

func pressed(number: int):
	selected_input = number;
	_animation_player.play("out");
	accepting_input = false;

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "in"):
		accepting_input = true;
	elif (anim_name == "out"):
		visible = false;
		emit_signal("result", selected_input);

func _on_ChoiceDice1_pressed():
	if (accepting_input):
		pressed(1);

func _on_ChoiceDice2_pressed():
	if (accepting_input):
		pressed(2);

func _on_ChoiceDice3_pressed():
	if (accepting_input):
		pressed(3);

func _on_ChoiceDice4_pressed():
	if (accepting_input):
		pressed(4);

func _on_ChoiceDice5_pressed():
	if (accepting_input):
		pressed(5);

func _on_ChoiceDice6_pressed():
	if (accepting_input):
		pressed(6);
