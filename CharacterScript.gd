extends Node3D

signal char_ready
signal char_reset

var up_distance: float = 1.3	
var up_duration: float = 0.7
var bob_distance: float = 0.1
var bob_duration: float = 0.2

func spawn():
	var start_pos = global_transform.origin
	var top_pos = start_pos + Vector3(0, up_distance, 0)
	var end_pos = top_pos - Vector3(0, bob_distance, 0)

	# Animate into the seat
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_reset)
	
	tween.tween_property(self, "global_transform:origin", top_pos, up_duration)
	tween.tween_property(self, "global_transform:origin", end_pos, bob_duration)
	
	# Activate plate
	emit_signal("char_ready", get_node("../Plate"))
	
	# Animate leaving
	tween.tween_interval(up_duration)
	tween.tween_property(self, "global_transform:origin", start_pos, up_duration)
	
func _on_reset():
	emit_signal("char_reset", get_parent())
