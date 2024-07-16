extends Node


signal update(value :float)
signal overheat(value :float)

const SPEED :float = 2000.0

var _heat :float = 100.0


func _process (delta_ :float) -> void:
    if Input.is_action_pressed("ui_accept"):
        if _heat > 0.0: update.emit(delta_ * SPEED)
        else: update.emit(0.0)
        _heat -= delta_ * SPEED * 0.008
        if _heat < 0.0: _heat = 0.0
    else:
        update.emit(0.0)
        _heat += delta_ * SPEED * 0.018
        if _heat > 100.0: _heat = 100.0

    overheat.emit(_heat)
