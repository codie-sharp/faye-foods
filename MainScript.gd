extends Node3D

@onready var camera = $Camera3D
@onready var timer = $SpawnTimer

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

	timer.timeout.connect(spawn_char)
	timer.start()

func _input(event):
	if event is InputEventMouseButton and !event.pressed:
		is_dragging = false

	elif is_dragging and event is InputEventMouseMotion:
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		
		var origin = camera.project_ray_origin(mousepos)
		var end = origin + camera.project_ray_normal(mousepos) * 10
		var query = PhysicsRayQueryParameters3D.create(origin, end, 1, [selected_food])
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)
		selected_food.global_transform.origin = result.position

func _on_food_selected(food):
	is_dragging = true
	selected_food = food

func spawn_char():
	if available_seats:
		var random_seat = available_seats.pop_at(randi_range(0, available_seats.size() - 1))
		random_seat.spawn_char()

func _on_seat_available(seat):
	available_seats.append(seat)
