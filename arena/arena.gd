extends Control

onready var textbox = $Textbox;

var DialogueText = load("res://textbox/dialogue_text.gd");
var leftPlayer = "";
var rightPlayer = "";
var current_page = 0;
var pages = [];

func _ready():
	self.leftPlayer = "Name1";
	self.rightPlayer = "Name2";
	self.pages = [
		["dialogue", [
			DialogueText.new(leftPlayer, "words words words...."),
			DialogueText.new(rightPlayer, "even more words words words...."),
		]],
		["choice", null],
	];
	play();

func play():
	current_page = 0;
	reset_page();

func reset_page():
	if (current_page >= pages.size()):
		return;
	
	var page = pages[current_page];
	print(page);
	if (page[0] == "dialogue"):
		textbox.dialogue = page[1];
		textbox.play();
	#elif (page[1] == "choice"):
	#	textbox.dialogue = page[1];


func _on_Textbox_new_page(name):
	if (name == leftPlayer):
		textbox.rect_position.x = 100;
	else:
		textbox.rect_position.x = 960 - 100 - textbox.rect_size.x;

func _on_Textbox_finished():
	current_page += 1;
	reset_page();
