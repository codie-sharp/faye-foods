extends Node3D

@onready var camera = $Camera3D
@onready var timer = $SpawnTimer

var food_meshes = []
var available_foods = []
var available_seats = []
var selected_food
var is_dragging = false

func _ready():
# Load resources
	var dir = DirAccess.open("res://FoodMeshes/")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		food_meshes.append(load("res://FoodMeshes/" + file_name))
		file_name = dir.get_next()

# Connect signals and set inital state
	var pantry_shelves = get_node("Counter/Pantry").get_children()
	for shelf in pantry_shelves:
		var food = shelf.get_node("Food")
		food.food_selected.connect(_on_food_selected)
		
		var food_mesh = food.get_node("Mesh")
		food_mesh.mesh = food_meshes[randi() % food_meshes.size()]
		available_foods.append(food)

	available_seats = get_node("Counter/Seats").get_children()
	for seat in available_seats:
		seat.seat_available.connect(_on_seat_available)

	timer.timeout.connect(spawn_char)
	
# Start game
	spawn_char()
	timer.start()

func _input(event):
	if event is InputEventMouseButton and !event.pressed:
		is_dragging = false
		selected_food.global_transform.origin = selected_food.get_parent().global_transform.origin
		selected_food = null

	elif is_dragging and event is InputEventMouseMotion:
		var space_state = get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		var origin = camera.project_ray_origin(mousepos)
		var end = origin + camera.project_ray_normal(mousepos) * 10
		var query = PhysicsRayQueryParameters3D.create(origin, end, 1, [selected_food])
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		if result:
			var normal = result.normal
			var radius = selected_food.get_node("Collider").shape.get_size().x / 2
			var target_position = result.position + result.normal * radius
			selected_food.global_transform.origin = selected_food.global_transform.origin.lerp(target_position, 0.2)

func _on_food_selected(food):
	is_dragging = true
	selected_food = food

func spawn_char():
	if available_seats:
		var random_seat = available_seats.pop_at(randi_range(0, available_seats.size() - 1))
		random_seat.spawn_char()

func _on_seat_available(seat):
	available_seats.append(seat)
