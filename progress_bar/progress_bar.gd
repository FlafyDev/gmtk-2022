extends Control

signal progress_bar_finished;

onready var _max_progress_label = $MaxProgressLabel;
onready var _progress_label = $Bar/ProgressLabel;
onready var _filled = $Bar/Filled;
onready var _tween = $Tween;

func _ready():
	pass

var progress: int = 5;
var max_progress: int = 0;

func set_max_progress(num: int):
	self.max_progress = num;
	_max_progress_label.text = str(self.max_progress);

func set_progress(num: int, animate: bool = true):
	var prev_progress = self.progress;
	self.progress = num;
	
	if (animate):
		_progress_label.text = str(prev_progress);
		
		_tween.interpolate_property(_filled, "anchor_top",
				1 - float(prev_progress)/self.max_progress,
				1 - float(self.progress)/self.max_progress, 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
		_tween.start();
	else:
		_progress_label.text = str(self.progress);
		_filled.anchor_top = 1 - float(self.progress)/self.max_progress;

func _on_Tween_tween_all_completed():
	_progress_label.text = str(self.progress);	
	emit_signal("progress_bar_finished");
