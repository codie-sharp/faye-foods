extends Node3D

signal seat_available

var character
var plate

func _ready():
	character = get_node("Character")
	character.char_seated.connect(_on_char_seated)
	character.char_exited.connect(_on_char_exited)
	
	plate = get_node("Plate")
	plate.food_plated.connect(_on_food_plated)

func spawn_char():
	character.sit()

func _on_char_seated():
	plate.change_state()

func _on_char_exited():
	plate.change_state()
	emit_signal("seat_available", self)

func _on_food_plated():
	character.exit()
