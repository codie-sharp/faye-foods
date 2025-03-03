extends Node3D

signal seat_available

@onready var character = $Character
@onready var plate = $Plate

func _ready():
	character.char_seated.connect(_on_char_seated)
	character.char_exited.connect(_on_char_exited)

func spawn_char(food):
	plate.food_wanted = food
	character.get_node("FoodMesh").mesh = food.get_node("Mesh").mesh

	character.sit()

func _on_char_seated():
	plate.change_state()

func _on_char_exited():
	plate.change_state()
	emit_signal("seat_available", self)
