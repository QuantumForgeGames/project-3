extends Node2D


const HEIGHT :int = 1080
const SPEED :float = 200.0

var _direction :float = -1.0 
# var _timer :Timer


func _ready () -> void:
    randomize()
    var random_dir = func(): _direction = [1, -1].pick_random()
    random_dir.call()

    var tween = get_tree().create_tween()
    tween.set_loops().tween_interval(3.0).finished.connect(random_dir)

    var random_loop = func(f):
        get_tree().create_timer(randf_range(1, 5)).timeout.connect(f.bind(f))
        _spawn()
    random_loop.call(random_loop)


func _process (_delta_ :float) -> void:

    if 40.0 > global_position.y or global_position.y > 1040.0:
        _direction *= -1.0

    global_position.y +=  SPEED * _direction *_delta_


func _spawn () -> void:

    var obstacles = owner.get_node("view/Obstacles")
    var obstacle = owner.obstacle.instantiate()
    obstacles.add_child(obstacle)
    obstacle.global_position = global_position
