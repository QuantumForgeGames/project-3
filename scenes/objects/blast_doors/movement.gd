extends Node


const SCROLL_SPEED :float = 200.0


func _process (_delta_ :float) -> void:
    if owner.global_position.x <= -100: owner.queue_free()
    var velocity :float = SCROLL_SPEED * _delta_
    owner.global_position.x -= velocity
