extends Control

signal text_finished;

onready var _text = $VBoxContainer/Text;
onready var _continue_indicator = $VBoxContainer/ContinueIndicator;
onready var _text_timer = $TextTimer;

var page = 0;
var pages = [
	"The casino game \"GAME_NAME\" requires 4 players."\
	+ "\nAll 4 players gamble the same amount of money"\
	+ " and the winner gets it all."\
	+ "\n\nTo determine the winner, "\
	+ "the game is separated into 3 rounds, where each round 2 players play against each "\
	+ "other and the other 2 players wait somewhere else until they finish.",
	
	"Each round the 2 players will be playing with 2 dice and alternately rolling them until the"\
	+ " sum of all the rolls"\
	+ " surpasses a certain threshold.\nThe one who reaches the threshold will be the winner of the round"\
	+ " and the other player will be out of the game",
	
	"The 2 players of the first round are decided by a dice."\
	+ "\n\nAfter the first round is over, the player who lost is out of the game"\
	+ " and the winner goes to the second round against the player to its left."\
	+ "\n\nSame thing after the second round.\nAt the end of the third round the winner is decided.",
	
	"You are the dice, and you can control what you'd roll. So you have a great advantage!",
];

func _ready():
	_continue_indicator.visible = false;
	_reset_page();

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if (_continue_indicator.visible):
			move_page();
		else:
			_text.visible_characters = _text.text.length()+111;

func _reset_page():
	_text.visible_characters = 0;
	_text_timer.start();
	_text.text = pages[page];

func move_page():
	page += 1;
	if page >= pages.size():
		_text.visible_characters = 0;
		_text.text = "";
		_text_timer.stop();
		_continue_indicator.visible = false;
		emit_signal("text_finished");
	else:
		_reset_page();

func _on_TextTimer_timeout():
	_text.visible_characters += 1;
	_continue_indicator.visible = \
		_text.visible_characters > _text.text.length();
	
