extends Control

signal found_match(current_match);

onready var _label = $VBoxContainer/Label;
onready var _player_indicators = [
	$VBoxContainer/HBoxContainer/Control/PlayerIndicator1,
	$VBoxContainer/HBoxContainer/Control/PlayerIndicator2,
	$VBoxContainer/HBoxContainer/Control/PlayerIndicator3,
	$VBoxContainer/HBoxContainer/Control/PlayerIndicator4,
];
onready var _choice = $VBoxContainer/HBoxContainer/Choice;
onready var _lines = [
	$VBoxContainer/HBoxContainer/Control/Line2D1,
	$VBoxContainer/HBoxContainer/Control/Line2D2,
	$VBoxContainer/HBoxContainer/Control/Line2D3,
	$VBoxContainer/HBoxContainer/Control/Line2D4,
	$VBoxContainer/HBoxContainer/Control/Line2D5,
	$VBoxContainer/HBoxContainer/Control/Line2D6,
];
onready var _dice = $VBoxContainer/HBoxContainer/Dice;
onready var _dramatic_match_timer = $DramaticMatchTimer;
onready var _players_mike = $Players/Mike;
onready var _players_rachel = $Players/Rachel;
onready var _players_james = $Players/James;
onready var _players_giorgio = $Players/Giorgio;

var players = [];
var current_match = [];
var players_out = [];
var time = 0;

func _physics_process(delta):
	time += delta;
	var yoffset = -abs(sin(time * 20) * 5);
	
	if (current_match.size() > 0):
		if !(0 in current_match):
			_players_mike.offset.x -= delta * 100;
			_players_mike.offset.y = yoffset;
		
		if !(1 in current_match):
			_players_rachel.offset.x -= delta * 150;
			_players_rachel.offset.y = yoffset;
		
		if !(2 in current_match):
			_players_james.offset.x += delta * 100;
			_players_james.offset.y = yoffset;

		if !(3 in current_match):
			_players_giorgio.offset.x += delta * 120;
			_players_giorgio.offset.y = yoffset;
		
		
		

func _ready():
	for player_indicator in _player_indicators:
		player_indicator.set_selected(false);
		player_indicator.set_out(false);
	
#	set_out([1])
#
#	dramatic_match(0, 2);
	
func dramatic_match(player1, player2):
	_label.text = "\nThe next match is between...";
	_dice.visible = false;
	_choice.visible = false;
	
	for line in _lines:
		line.visible = false;
	
	current_match = [player1, player2];
	_dramatic_match_timer.start();

func first_roll():
	_label.text = "\nRoll the first match.";
	_dice.visible = true;
	_choice.visible = true;
	_choice.start();

func set_players(players):
	self.players = players;
	for i in range(_player_indicators.size()):
		var player_indicator = _player_indicators[i];
		player_indicator.text = players[i];

func set_current_match(player1, player2):
	current_match = [player1, player2];
	for i in range(_player_indicators.size()):
		var player_indicator = _player_indicators[i];
		player_indicator.set_selected(i == player1 || i == player2);
	
	emit_signal("found_match", current_match);

func set_out(players: Array):
	players_out = players;
	for player_out in players_out:
		_player_indicators[player_out].set_out(true);

func _on_Choice_result(number):
	_dice.visible = true;
	_dice.animate(number);

func _on_Dice_animation_end():
	for line in _lines:
		line.visible = false;
	
	_lines[_dice.number - 1].visible = true;
	if (_dice.number == 1):
		set_current_match(0, 1);
	if (_dice.number == 2):
		set_current_match(2, 3);
	if (_dice.number == 3):
		set_current_match(0, 2);
	if (_dice.number == 4):
		set_current_match(1, 3);
	if (_dice.number == 5):
		set_current_match(0, 3);
	if (_dice.number == 6):
		set_current_match(1, 2);

func _on_DramaticMatchTimer_timeout():
	set_current_match(current_match[0], current_match[1]);
