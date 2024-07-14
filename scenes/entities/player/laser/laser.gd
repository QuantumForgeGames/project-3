extends Node2D


var _length :float = 0.0

@onready var _CollisionShape_ :CollisionShape2D = $Area2D/CollisionShape2D


func handle_update (value_ :float) -> void:
    if value_ > 0.0: _length += value_
    else: _length = 0.0

    _CollisionShape_.shape.size.x = int(_length)
    _CollisionShape_.position.x = _length /2.0
    queue_redraw()


func _draw () -> void:
    draw_line(Vector2(0.0, 0.0), Vector2(_length, 0.0), Color(1.0, 1.0, 1.0, 1.0), 30.0)



func _on_area_2d_body_entered(body):
    pass # Replace with function body.


func _on_area_2d_body_exited(body):
    pass # Replace with function body.
