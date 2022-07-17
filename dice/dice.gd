extends Node2D

signal animation_end;

onready var _bottom_number_sprite = $DiceContainer/BottomNumber;
onready var _top_number_sprite = $DiceContainer/TopNumber;
onready var _animation_player = $AnimationPlayer;

var number: int = 2;
var _rng = RandomNumberGenerator.new();

func _ready():
	_rng.randomize();

func _input(event):
	if OS.is_debug_build() && event.is_action_pressed("ui_accept"):
		Engine.time_scale = 100;

func animate(number: int):
	self.number = number;
	_animation_player.play("fall");
	
func set_number_random():
	var num = _rng.randi_range(1, 5);
	set_number(num + int(num >= number));

# bottom_number = 0 means random.
# bottom_number = -1 means no number.
func set_number(top_number = null, bottom_number: int = 0):
	if (top_number == null):
		top_number = number;
	
	if bottom_number == 0:
		bottom_number = _rng.randi_range(1, 5)
		bottom_number += int(bottom_number >= top_number);
	
	_top_number_sprite.texture = _get_number_sprite(top_number, "top");
	if (bottom_number == -1):
		_bottom_number_sprite.texture = null;
	else:
		_bottom_number_sprite.texture = \
			_get_number_sprite(bottom_number, "bottom");

func _get_number_sprite(number: int, side: String):
	return load("res://dice/parts/%s_%s.png" % [_name_to_number[number], side]);

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "fall"):
		emit_signal("animation_end");

var _name_to_number = [
	"zero",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
];

