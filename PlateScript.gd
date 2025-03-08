extends Area3D

signal correct_food
signal wrong_food

var active = false
var food_wanted # directly set by parent

func change_state():
	active = !active

func check_food(plated_food):
	if plated_food == food_wanted:
		emit_signal("correct_food")
	else:
		emit_signal("wrong_food")
