

class_name Player
extends CharacterBody2D

@export var fuel_label: Label
@export var heat_label: Label


func _ready () -> void:
    get_node('process/Health').update.connect(get_node('view/Health').handle_update)
    get_node('process/Shooting').update.connect(get_node('view/Laser').handle_update)
    # get_node('process/Shooting').overheat.connect(get_node('view/Overheat').handle_update)


func _notification(_what :int) -> void:
    if _what == NOTIFICATION_PREDELETE:
        AudioManager.play_stream_oneshot(AudioManager.audio_player_death)
