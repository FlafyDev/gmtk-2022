extends Control

signal animation_finished;

onready var _animation_player = $AnimationPlayer;
onready var _man = $Man;

var in_or_out;

func show_man():
	_animation_player.play("open");

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "open"):
		_animation_player.play("man_%s" % [in_or_out]);
	
	if (anim_name == "man_in" || anim_name == "man_out"):
		emit_signal("animation_finished");
