extends CharacterBody2D


func _ready () -> void:
	get_node('process/Health').update.connect(get_node('view/Health').handle_update)

	var tween = get_tree().create_tween().set_loops()
	tween.tween_interval(randf_range(2.0, 4.0)).finished.connect(func():
		get_node('process/Health').take_damage(floor(randf_range(5, 15)))
	)
