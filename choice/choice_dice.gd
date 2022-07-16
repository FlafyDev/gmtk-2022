extends Control

export(int) var number = 1;

onready var _dice = $Dice;
onready var _shadow = $ColorRect;

signal pressed;

# Called when the node enters the scene tree for the first time.
func _ready():
	_dice.set_number(number, -1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ChoiceDice_mouse_entered():
	_shadow.visible = true;


func _on_ChoiceDice_mouse_exited():
	_shadow.visible = false;

func _on_ChoiceDice_gui_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed()):
			emit_signal("pressed");
		
