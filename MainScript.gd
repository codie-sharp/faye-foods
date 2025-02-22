extends Node3D

var char = preload("res://Character1.tscn").instantiate()
var seats: Dictionary = {}

func _ready():
	init_seats()
	spawn_char()

func init_seats():
	var seats_node = get_node("Counter/Seats")
	for seat in seats_node.get_children():
		seats[seat.index] = {
			"position": seat.global_transform.origin,
			"ready": true
		}
		seat.seat_state_changed.connect(_on_seat_state_changed)

func spawn_char():
	var random_seat = seats[randi_range(0, seats.size() - 1)]
	char.global_transform.origin = random_seat["position"] - Vector3(0, char.move_distance, 0)
	add_child(char)

func _on_seat_state_changed(index, ready):
	print(index, ready)
