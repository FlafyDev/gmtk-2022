extends Node2D

onready var _fade_in_tween = $FadeInTween;

var Overview = load("res://overview/overview.tscn");
var Arena = load("res://arena/arena.tscn");

enum SceneType {
	OVERVIEW,
	ARENA,
};
var transitioning_color_rect = null;

var current_scene_type = null;
var current_scene = null;

func switch_scene(scene):
	if (transitioning_color_rect == null):
		transitioning_color_rect = ColorRect.new();
		transitioning_color_rect.rect_size = Vector2(960, 540);
		add_child(transitioning_color_rect);
		_fade_in_tween.interpolate_property(transitioning_color_rect, "color",\
			Color(0, 0, 0, 0), Color.black, 3
		);
		_fade_in_tween.start();
		current_scene = scene.instance();
	else:
		print("TRIED TO CHANGE SCENE WHILE CHANGING.");

func _ready():
	current_scene_type = SceneType.ARENA;
	switch_scene(Arena);

func switched_scene():
	print("YA");

func _on_FadeInTween_tween_all_completed():
	remove_child(transitioning_color_rect);
	add_child(current_scene);
	switched_scene();
