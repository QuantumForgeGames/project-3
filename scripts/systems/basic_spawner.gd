extends Node2D


@export var _object :PackedScene


func _ready () -> void:
	randomize()

	var random_loop = func(f):
		get_tree().create_timer(randf_range(1, 5)).timeout.connect(f.bind(f))
		_spawn()
	random_loop.call(random_loop)


func _spawn () -> void:

	# var obstacles = owner.get_node("view/Obstacles")
	var obstacle = _object.instantiate()
	add_child(obstacle)
	obstacle.global_position = global_position
