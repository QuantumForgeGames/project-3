extends Node


const SCROLL_SPEED :float = 100

@export var _target_close_distance :float = 0.1

var _current_point :int = 0
var _process_func :Callable


func _ready () -> void:

    if owner.move_line != null:
        _process_func = _move_path
        owner.global_position = owner.move_line.get_point_position(_current_point)
        _current_point += 1
    else:
        _process_func = _move_scroll



func _process (_delta_ :float) -> void:
    _process_func.call(_delta_)   


func _move_path (_delta_ :float) -> void:
    if _current_point > owner.move_line.get_point_count(): owner.queue_free()

    var target = owner.move_line.get_point_position(_current_point)
    if owner.global_position.distance_to(target) < _target_close_distance:
        _current_point += 1
        return

    owner.velocity = (target - owner.global_position).normalized() * SCROLL_SPEED * _delta_
    owner.move_and_collide(owner.velocity)


func _move_scroll (_delta_ :float) -> void:
    if owner.global_position.x <= -100: owner.queue_free()
    owner.velocity = Vector2.LEFT * SCROLL_SPEED * _delta_
    owner.move_and_collide(owner.velocity)
