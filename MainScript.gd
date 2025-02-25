extends Node3D

var available_seats = []
var pantry = []
var selected_food
var is_dragging = false

func _ready():
	pantry = get_node("Counter/Pantry").get_children()
	for food in pantry:
		food.food_selected.connect(_on_food_selected)

	available_seats = get_node("Counter/Seats").get_children()
	for seat in available_seats:
		seat.seat_available.connect(_on_seat_available)

	spawn_char()

	var timer = get_node("SpawnTimer")
	timer.timeout.connect(spawn_char)
	timer.start()

func _input(event):
	if event is InputEventMouseButton and !event.pressed:
		is_dragging = false

	#elif is_dragging and event is InputEventMouseMotion:
		## update dragged mesh here

func _on_food_selected(food):
	is_dragging = true
	selected_food = food

func spawn_char():
	if available_seats:
		var random_seat = available_seats.pop_at(randi_range(0, available_seats.size() - 1))
		random_seat.spawn_char()

func _on_seat_available(seat):
	available_seats.append(seat)
