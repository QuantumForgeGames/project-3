extends Node


const DAMAGE_RATE :float = 60.0

var _process_damages :Array = []

@onready var _health_top :Node = $'../Health_Top'
@onready var _health_bottom :Node = $'../Health_Bottom'


func _process (delta_ :float) -> void:
    for node in _process_damages:
        node.take_damage(delta_ *DAMAGE_RATE)


func _on_area_2d1_area_entered (area) -> void:
    start_damage(_health_top)


func _on_area_2d1_area_exited (area) -> void:
    stop_damage(_health_top)


func _on_area_2d2_area_entered (area) -> void:
    start_damage(_health_bottom)


func _on_area_2d2_area_exited (area) -> void:
    stop_damage(_health_bottom)


func start_damage (health_ :Node) -> void:
    # print("start Health: ", health_.name)
    if not _process_damages.has(health_):
        _process_damages.append(health_)


func stop_damage (health_ :Node) -> void:
    # print("stop Health: ", health_.name)
    if _process_damages.has(health_):
        _process_damages.erase(health_)
