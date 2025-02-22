extends Node3D

@export var move_distance: float = 1.0
@export var move_duration: float = 0.5

func _ready():
	var tween = get_tree().create_tween()
	var start_pos = global_transform.origin
	print(start_pos)
	var target_pos = start_pos + Vector3(0, move_distance, 0)
	print(target_pos)

	tween.tween_property(self, "global_transform:origin", target_pos, move_duration)
