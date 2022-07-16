extends Control

onready var textbox = $Textbox;
onready var progress_bar = $CenterContainer/ProgressBar;
onready var choice = $Choice;
onready var dice_left = $DiceLeft;
onready var dice_right = $DiceRight;
onready var after_progress_bar_wait = $AfterProgressBarWait;

var DialogueText = load("res://textbox/dialogue_text.gd");
var leftPlayer = "";
var rightPlayer = "";
var _rng = RandomNumberGenerator.new();
var dice_goal = 0;
var dice_sum = 0;
var get_event: FuncRef = null; # args: (next_turn: Turn, current_sum: int)

enum Turn {
	LEFT,
	RIGHT,
};

var turn = Turn.LEFT;

func _ready():
	_rng.randomize();
	progress_bar.visible = false;

#	start(21);

#func generate_event(a, b):
#	return ["dialogue", 10, "Name 1", "Name 2", [
#			DialogueText.new("Name 1", "words words words...."),
#			DialogueText.new("Name 2", "even more words words words...."),
#		]];

func start(goal: int, initial_turn = Turn.RIGHT):
	progress_bar.visible = true;
	dice_sum = 0;
	turn = initial_turn;
	progress_bar.set_max_progress(goal);
	progress_bar.set_progress(dice_sum, false);
	do_turn();

func do_turn():
	if (turn == Turn.RIGHT):
		choice.start();
	else:
		var number: int = _rng.randi_range(1, 6);
		dice_sum += number;
		dice_left.animate(number);

func process_event(event):
	var type = event[0];
	if (type == "dialogue"):
		var minimum_sum = event[1];
		if (dice_sum >= minimum_sum):
			leftPlayer = event[2];
			rightPlayer = event[3];
			textbox.dialogue = event[4];
			textbox.play();
		else:
			do_turn();

func _on_Choice_result(number):
	dice_sum += number;
	dice_right.animate(number);

func _on_DiceLeft_animation_end():
	progress_bar.set_progress(dice_sum);

func _on_DiceRight_animation_end():
	progress_bar.set_progress(dice_sum);

func _on_ProgressBar_progress_bar_finished():
	after_progress_bar_wait.start();

func _on_AfterProgressBarWait_timeout():
	turn = Turn.RIGHT if turn == Turn.LEFT else Turn.LEFT;
	
	var event = get_event.call_func(turn, dice_sum) \
		if get_event != null else null;
	
	if (event == null):
		do_turn();
	else:
		process_event(event);

func _on_Textbox_new_page(name):
	if (name == leftPlayer):
		textbox.rect_position.x = 100;
	else:
		textbox.rect_position.x = 960 - 100 - textbox.rect_size.x;

func _on_Textbox_finished():
	do_turn();

