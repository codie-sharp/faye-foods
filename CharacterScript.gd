extends Node3D

signal char_seated
signal char_exited

var up_distance: float = 1.3	
var up_duration: float = 0.7
var bob_distance: float = 0.1
var bob_duration: float = 0.2

var start_pos
var top_pos
var end_pos

func _ready():
	start_pos = global_transform.origin
	top_pos = start_pos + Vector3(0, up_distance, 0)
	end_pos = top_pos - Vector3(0, bob_distance, 0)

func sit():
	var tween = get_tree().create_tween()
	tween.finished.connect(emit_char_seated)
	tween.tween_property(self, "global_transform:origin", top_pos, up_duration)
	tween.tween_property(self, "global_transform:origin", end_pos, bob_duration)

func exit():
	var tween = get_tree().create_tween()
	tween.finished.connect(emit_char_exited)
	tween.tween_property(self, "global_transform:origin", start_pos, up_duration)

func emit_char_seated():
	emit_signal("char_seated")

func emit_char_exited():
	emit_signal("char_exited")
