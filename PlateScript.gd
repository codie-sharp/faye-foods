extends Area3D

signal food_plated

var state = false

func _ready():
	connect("input_event", _on_input_event)
	connect("area_entered", _on_area_entered)

func _on_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	# Body entered?
	if state and event is InputEventMouseButton and event.pressed:
		emit_signal("food_plated")

func change_state():
	state = !state

func _on_area_entered():
	if state:
		print("area_entered")
