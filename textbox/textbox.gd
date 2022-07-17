extends Control

signal finished;
signal new_page(name);

onready var textNode = $Margin/Text;
onready var _name_text = $ColorRect/Name;

var dialogue: Array = [];
var current_page = 0;
var playing = false;

func _ready():
	visible = false;

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if (playing && textNode.visible_characters > textNode.text.length()):
			current_page += 1;
			reset_page();

func play():
	playing = true;
	visible = true;
	current_page = 0;
	reset_page();
	
func reset_page():
	if (current_page >= dialogue.size()):
		playing = false;
		visible = false;
		emit_signal("finished");
		return;
	
	var dialogue_text = dialogue[current_page];
	
	emit_signal("new_page", dialogue_text[0]);
	_name_text.text = dialogue_text[0];
	textNode.text = dialogue_text[1];
	textNode.visible_characters = 0;

func _on_Timer_timeout():
	textNode.visible_characters += 1;
