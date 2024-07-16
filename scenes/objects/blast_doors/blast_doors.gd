extends Node2D


enum DoorState { TOP, BOTTOM, BOTH }

const DOWN_50 :int = int(1080 /2)
const DOWN_25 :int = int(1080 /4)
const UP_25 :int = 1080 -DOWN_25
const UP_50 :int = 1080 -DOWN_50

@export var _door_close_state :DoorState = DoorState.BOTH


func _ready () -> void:

    var down_val :int
    var up_val : int

    match _door_close_state:
        DoorState.TOP:
            # down_val = randi_range(DOWN_25, DOWN_50)
            down_val = DOWN_50
            up_val = 1080
        DoorState.BOTTOM:
            down_val = 0
            # up_val = randi_range(UP_25, UP_50)
            up_val = UP_50
        DoorState.BOTH:
            down_val = DOWN_25
            up_val = UP_25
            # down_val = randi_range(0, DOWN_25)
            # up_val = randi_range(1080, UP_25)

    var tween = get_tree().create_tween()
    tween.tween_property(get_node('view/Door_Top'), "global_position:y", down_val, randf_range(1, 3)).from(0)
    tween.parallel().tween_property(get_node('view/Door_Bottom'), "global_position:y", up_val, randf_range(1, 3)).from(1080)
    tween.parallel().tween_callback(func():
        AudioManager.play_stream_oneshot(AudioManager.audio_vines_moving.pick_random())
        AudioManager.play_stream_oneshot(AudioManager.audio_vines_moving.pick_random())
    )


func _notification(_what :int) -> void:
    if _what == NOTIFICATION_PREDELETE:
        AudioManager.play_stream_oneshot(AudioManager.audio_vines_breaking.pick_random())
