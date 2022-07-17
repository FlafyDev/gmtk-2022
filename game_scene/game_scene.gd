extends Node2D

onready var _fade_in_tween = $FadeInTween;
onready var _delay_timer = $DelayTimer;
onready var _delay_2_timer = $Delay2Timer;

var num_of_round = 0;
var current_match = null;
var players = [
	"Mike",
	"Rachel",
	"James",
	"Giorgio",
];
var players_out = [];
var event_provider;

func _ready():
	event_provider = load("res://event_provider/event_provider.gd").new();
	switch_to_instructions();

func reset_all():
	players_out = [];
	event_provider.previous_matches = [];

func switched_scene():
	match current_scene_type:
		SceneType.OVERVIEW:
			current_scene.set_out(players_out);
			current_scene.set_players(players);
			
			if (num_of_round == 0):
				current_scene.first_roll();
			else:
				current_scene.dramatic_match(\
					current_match[0], current_match[1]);
			
		SceneType.ARENA:
			current_scene.get_events = event_provider.get_events(current_match);
			event_provider.previous_matches.append(current_match);
			
			current_scene.set_players(\
				players[current_match[0]],\
				players[current_match[1]]);
				
			current_scene.start([
				12,
				7,
				32,
			][num_of_round]);
		
		SceneType.ENDING:
			current_scene.ending("bad");

func _on_overview_found_match(new_match):
	current_match = new_match;
	_delay_timer.start();

func _on_arena_found_winner(winner):
	num_of_round += 1;
	winner = current_match[0] if winner == players[current_match[0]] \
		else current_match[1];
	
	var loser = current_match[1] if current_match[0] == winner else \
		current_match[0];
	
	players_out.append(loser);
	
	if (players_out.size() < 3):
		current_match = [winner, winner];
		while true:
			current_match[1] = [1, 3, 0, 2][current_match[1]];
			if (!(current_match[1] in players_out)):
				break;

		_delay_2_timer.start();
	else:
		switch_to_ending();

func _on_instructions_finished():
	switch_to_overview();

func _on_ending_finished():
	switch_to_instructions();

func _on_DelayTimer_timeout():
	switch_to_arena();

func _on_Delay2Timer_timeout():
	switch_to_overview();

# SCENE STUFF
enum SceneType {
	OVERVIEW,
	ARENA,
	INSTRUCTIONS,
	ENDING,
};
var transitioning_color_rect = null;
var current_scene_type = null;
var current_scene = null;
var scene_to_change_to = null;

var Overview = load("res://overview/overview.tscn");
var Arena = load("res://arena/arena.tscn");
var Instructions = load("res://game_instructions/game_instructions.tscn");
var Ending = load("res://game_ending/game_ending.tscn");

func switch_to_ending():
	current_scene_type = SceneType.ENDING;
	switch_scene(Ending);

func switch_to_instructions():
	reset_all();
	current_scene_type = SceneType.INSTRUCTIONS;
	switch_scene(Instructions);

func switch_to_arena():
	current_scene_type = SceneType.ARENA;
	switch_scene(Arena);

func switch_to_overview():
	current_scene_type = SceneType.OVERVIEW;
	switch_scene(Overview);

func switch_scene(scene):
	if (transitioning_color_rect == null):
		transitioning_color_rect = ColorRect.new();
		transitioning_color_rect.color = Color(0, 0, 0, 0);
		transitioning_color_rect.rect_size = Vector2(960, 540);
		add_child(transitioning_color_rect);
		_fade_in_tween.interpolate_property(transitioning_color_rect,\
		 	"color", null, Color.black, 1
		);
		_fade_in_tween.start();
		scene_to_change_to = scene.instance();
	else:
		print("TRIED TO CHANGE SCENE WHILE CHANGING.");

func _on_FadeInTween_tween_all_completed():
	remove_child(transitioning_color_rect);
	transitioning_color_rect = null;
	remove_child(current_scene);
	current_scene = scene_to_change_to;
	add_child(current_scene);
	
	match (current_scene_type):
		SceneType.OVERVIEW:
			current_scene.connect("found_match", self, \
				"_on_overview_found_match");
		SceneType.ARENA:
			current_scene.connect("found_winner", self, \
				"_on_arena_found_winner");
		SceneType.INSTRUCTIONS:
			current_scene.connect("text_finished", self, \
				"_on_instructions_finished");
		SceneType.ENDING:
			current_scene.connect("text_finished", self, \
				"_on_ending_finished");
	
	switched_scene();
