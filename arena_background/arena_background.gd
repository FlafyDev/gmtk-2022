extends Control

signal animation_finished;

onready var animation_player = $AnimationPlayer;
onready var _left_player_sprite = $LeftPlayer;
onready var _right_player_sprite = $RightPlayer;
onready var _purse = $Purse;

var in_or_out;
var left_player;
var right_player;

func set_players(left_player, right_player):
	self.left_player = left_player;
	self.right_player = right_player;
	_left_player_sprite.texture = get_silhouette_image(left_player);
	_right_player_sprite.texture = get_silhouette_image(right_player);

func get_silhouette_image(player):
	match player:
		"Mike":
			return load("res://arena_background/Mike_idle.png");
		"Rachel":
			return load("res://arena_background/Rachel_idle.png");
		"James":
			return load("res://arena_background/James_idle.png");
		"Giorgio":
			return load("res://arena_background/Giorgio_idle.png");

func set_bag(visible: bool):
	_purse.visible = visible;

func show_man():
	animation_player.play("open_friend");

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "open_friend"):
		animation_player.play("man_%s" % [in_or_out]);
	
	if (anim_name == "man_in" || anim_name == "man_out"):
		emit_signal("animation_finished");
