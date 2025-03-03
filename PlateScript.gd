extends Area3D

signal food_plated
signal food_unplated
signal correct_food
signal wrong_food

var active = false
var food_wanted # directly set by parent

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func change_state():
	active = !active

func check_food(plated_food):
	if plated_food == food_wanted:
		emit_signal("correct_food")
	else:
		emit_signal("wrong_food")

# Pass self to Main when food plated
func _on_area_entered(_area):
	if active:
		emit_signal("food_plated", self)

func _on_area_exited(_area):
	if active:
		emit_signal("food_unplated")
