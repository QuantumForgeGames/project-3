

class_name Player
extends CharacterBody2D


func _ready () -> void:
    get_node('process/Health').update.connect(get_node('view/Health').handle_update)
    get_node('process/Shooting').update.connect(get_node('view/Laser').handle_update)
    # get_node('process/Shooting').overheat.connect(get_node('view/Overheat').handle_update)
