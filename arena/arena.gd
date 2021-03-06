extends Control

signal found_winner(player, bag_stayed);

onready var textbox = $Textbox;
onready var progress_bar = $CenterContainer/ProgressBar;
onready var choice = $Choice;
onready var dice_left = $DiceLeft;
onready var dice_right = $DiceRight;
onready var after_progress_bar_wait = $AfterProgressBarWait;
onready var left_player_indicator = $HBoxContainer/CenterContainer3/LeftPlayerIndicator;
onready var right_player_indicator = $HBoxContainer/CenterContainer4/RightPlayerIndicator;
onready var end_round_label = $CenterContainer2/EndRoundLabel;
onready var arena_background = $ArenaBackground;

var DialogueText = load("res://textbox/dialogue_text.gd");
var left_player = "";
var right_player = "";
var _rng = RandomNumberGenerator.new();
var dice_goal = 0;
var dice_sum = 0;
var get_events: FuncRef = null;
var events = null;
var good_ending = false;
# args: (next_turn: Turn, current_sum: int, winner_name: String, left_player: String, right_player: String)

enum Turn {
	LEFT,
	RIGHT,
};

var turn = Turn.LEFT;
var winner = null;
var bag_stayed = false;

func _ready():
	_rng.randomize();
	left_player_indicator.set_out(false);
	left_player_indicator.set_selected(false);
	right_player_indicator.set_out(false);
	right_player_indicator.set_selected(false);
	
	progress_bar.visible = false;

#	start(21);

#func generate_event(a, b):
#	return ["dialogue", 10, "Name 1", "Name 2", [
#			DialogueText.new("Name 1", "words words words...."),
#			DialogueText.new("Name 2", "even more words words words...."),
#		]];


func start(goal: int, bag_stayed: bool = false):
	arena_background.set_bag(bag_stayed);
	progress_bar.visible = true;
	dice_sum = 0;
	dice_goal = goal;
	turn = Turn.RIGHT;
	progress_bar.set_max_progress(goal);
	progress_bar.set_progress(dice_sum, false);
	arena_background.set_players(left_player, right_player);
	do_turn();

func do_turn():
	if (winner != null):
		if (winner == left_player):
			end_round_label.text = right_player + " LOST.";
			end_round_label.set("custom_colors/font_color", Color.red);
		
		if (winner == right_player):
			end_round_label.text = right_player + " WON!";
			end_round_label.set("custom_colors/font_color", Color.green);
		
		emit_signal("found_winner", winner, false if winner == "Rachel" else bag_stayed, good_ending);
		return;
	
	if (turn == Turn.RIGHT):
		choice.start();
	else:
		var number: int = _rng.randi_range(1, 6);
		dice_sum += number;
		dice_left.animate(number);


func set_players(left_player, right_player):
	self.left_player = left_player;
	self.right_player = right_player;
	left_player_indicator.text = left_player;
	right_player_indicator.text = right_player;

func process_event(event):
	var type = event[0];
	match type:
		"wait":
			yield(get_tree().create_timer(event[1]), "timeout")
		"dialogue":
			textbox.dialogue = event[1];
			textbox.play();
			yield(textbox, "finished");
		"man_in":
			arena_background.in_or_out = "in";
			arena_background.show_man();
			yield(arena_background, "animation_finished");
		"man_out":
			arena_background.in_or_out = "out";
			arena_background.show_man();
			yield(arena_background, "animation_finished");
		"open_agents":
			arena_background.animation_player.play("open_agents");
			yield(arena_background.animation_player, "animation_finished");
		"james_gun":
			arena_background.animation_player.play("james_gun");
			yield(arena_background.animation_player, "animation_finished");
		"gang_in_and_out":
			arena_background.animation_player.play("gang_in_and_out");
			yield(arena_background.animation_player, "animation_finished");
		"giorgio_no_phone":
			var side = "left" if (left_player == "Giorgio") else "right";
			arena_background.animation_player.play("giorgio_no_phone_%s" % [side]);
			yield(arena_background.animation_player, "animation_finished");
		"giorgio_phone":
			var side = "left" if (left_player == "Giorgio") else "right";
			arena_background.animation_player.play("giorgio_phone_%s" % [side]);
			yield(arena_background.animation_player, "animation_finished");
		"giorgio_phone_ring":
			var side = "left" if (left_player == "Giorgio") else "right";
			print("giorgio_phone_ring_%s" % [side]);
			arena_background.animation_player.play("giorgio_phone_ring_%s" % [side]);
			yield(arena_background.animation_player, "animation_finished");
		"rachel_walks_in":
			arena_background.animation_player.play("rachel_walks_in");
			yield(arena_background.animation_player, "animation_finished");
		"rachel_walks_out":
			arena_background.animation_player.play("rachel_walks_out");
			yield(arena_background.animation_player, "animation_finished");
		"rachel_slap":
			bag_stayed = true;
			arena_background.animation_player.play("rachel_slap");
			yield(arena_background.animation_player, "animation_finished");
		"gang_arrested":
			good_ending = true;
			arena_background.animation_player.play("gang_arrested");
			yield(arena_background.animation_player, "animation_finished");
		"rachel_walks_out_back":
			arena_background.animation_player.play("rachel_walks_out_back");
			yield(arena_background.animation_player, "animation_finished");
		"rachel_walks_in_front":
			arena_background.animation_player.play("rachel_walks_in_front");
			yield(arena_background.animation_player, "animation_finished");
		"open_gang":
			arena_background.animation_player.play("open_gang");
			yield(arena_background.animation_player, "animation_finished");
		_:
			print("ERROR: unknown event type: %s" % [type]);
	
	do_next_event();

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
	winner = turn if dice_sum >= dice_goal else null;
	if (winner != null):
		winner = left_player if winner == Turn.LEFT else right_player;
	
	turn = Turn.RIGHT if turn == Turn.LEFT else Turn.LEFT;
	
	events = get_events.call_func(turn, dice_sum, winner, left_player, right_player) \
		if get_events != null else null;
	
	do_next_event();

func do_next_event():
	var event = events.pop_front() if events != null else null;
	if (event == null):
		do_turn();
	else:
		process_event(event);

func _on_Textbox_new_page(name):
	if (name == left_player):
		textbox.rect_position.x = 50;
		textbox.rect_position.y = 540 - textbox.rect_size.y - 60;
	elif (name == right_player):
		textbox.rect_position.x = 960 - textbox.rect_size.x - 50;
		textbox.rect_position.y = 540 - textbox.rect_size.y - 60;
	else:
		textbox.rect_position.x = (960 - textbox.rect_size.x)/2;
		textbox.rect_position.y = 540 - textbox.rect_size.y - 20;

