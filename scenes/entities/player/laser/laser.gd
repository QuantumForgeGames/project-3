extends Node2D


var _length :float = 0.0


func handle_update (value_ :float) -> void:
    if value_ > 0.0: _length += value_
    else: _length = 0.0
    queue_redraw()


func _draw () -> void:
    draw_line(Vector2(0.0, 0.0), Vector2(_length, 0.0), Color(1.0, 1.0, 1.0, 1.0), 30.0)

