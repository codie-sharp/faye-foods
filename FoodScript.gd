extends Area3D

signal food_selected

func _ready():
	connect("input_event", _on_input_event)

func _on_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("food_selected", self)
