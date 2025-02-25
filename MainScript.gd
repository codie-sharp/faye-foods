extends Node3D

var available_seats = []

func _ready():
	available_seats = get_node("Counter/Seats").get_children()
	for seat in available_seats:
		seat.seat_available.connect(_on_seat_available)
	spawn_char()

	var timer = get_node("SpawnTimer")
	timer.timeout.connect(spawn_char)
	timer.start()

func spawn_char():
	if available_seats:
		var random_seat = available_seats.pop_at(randi_range(0, available_seats.size() - 1))
		random_seat.spawn_char()

func _on_char_ready(plate):
	print(plate)

func _on_seat_available(seat):
	available_seats.append(seat)
