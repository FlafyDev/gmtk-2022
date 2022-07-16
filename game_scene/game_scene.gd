extends Node2D

var Overview = load("res://overview/overview.tscn");
var Arena = load("res://arena/arena.tscn");

var current_scene = null;

func switch_scene(scene):
	if (current_scene):
		remove_child(current_scene);
	
	current_scene = scene.new();
	add_child(current_scene);

func _ready():
	switch_scene(Overview.new());
