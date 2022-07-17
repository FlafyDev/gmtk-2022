extends Control

signal text_finished;

onready var _text = $VBoxContainer/Text;
onready var _continue_indicator = $VBoxContainer/ContinueIndicator;
onready var _text_timer = $TextTimer;

var page = 0;

var pages;

func _ready():
	_continue_indicator.visible = false;

func ending(type):
	match type:
		"good":
			pages = [
				"The next day a newspaper rolled out. A detective found out gansters were"\
				+ " planning to rob the casino.",
			];
		"bad":
			pages = [
				"A few days later, a group of gangsters robbed everyone in the"\
				+ " casino.",
				"I wonder, could you have done anything to stop it?",
			];
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
	
