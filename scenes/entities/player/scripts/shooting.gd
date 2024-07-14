extends Node


signal update(value :float)

const SPEED :float = 2000.0


func _process (delta_ :float) -> void:
    if Input.is_action_pressed("ui_accept"):
        update.emit(delta_ * SPEED)
    else:
        update.emit(0.0)
