extends Node


signal update(value :float)
signal overheat(value :float)

const SPEED :float = 2000.0

var _heat :float = 100.0
var _laser_fire_loop :AudioStreamPlayer = null
var _overheated :bool = true
var recharged :bool = false


func _process (delta_ :float) -> void:
    if Input.is_action_pressed("ui_accept"):
        if _heat > 0.0: update.emit(delta_ * SPEED)
        else: update.emit(0.0)
        _heat -= delta_ * SPEED * 0.008
        if _heat < 0.0:
            if _overheated == true: AudioManager.play_stream_oneshot(AudioManager.audio_laser_overheat)
            _heat = 0.0
            _overheated = false
            recharged = false

    else:
        update.emit(0.0)
        _heat += delta_ * SPEED * 0.018
        if _heat > 100.0:
            if recharged == false: AudioManager.play_stream_oneshot(AudioManager.audio_laser_ready)
            _heat = 100.0
            recharged = true
            _overheated = true


    if Input.is_action_just_pressed("ui_accept"):
        if _heat <= 0.0: AudioManager.play_stream_oneshot(AudioManager.audio_laser_overheat)
        else:
            AudioManager.play_stream_oneshot(AudioManager.audio_laser_fire_initial)
            if _laser_fire_loop == null: _laser_fire_loop = AudioManager.get_play_stream_reference(AudioManager.audio_laser_fire_loop)
            else: _laser_fire_loop.queue_free()
    elif Input.is_action_just_released("ui_accept"):
        if _laser_fire_loop != null: _laser_fire_loop.queue_free()


    overheat.emit(_heat)


func _notification(_what :int) -> void:
    if _what == NOTIFICATION_PREDELETE:
        if _laser_fire_loop != null: _laser_fire_loop.queue_free()
