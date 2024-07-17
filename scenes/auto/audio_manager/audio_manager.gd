extends Node2D


@export var _AudioSpawner :Node

@export_group("background")
@export var _LevelMusic :AudioStreamPlayer
@export var _MenuMusic :AudioStreamPlayer
@export var _AmbientSound :AudioStreamPlayer

@export_group("vines")
@export var audio_vines_breaking :Array[AudioStreamWAV] = []
@export var audio_vines_moving :Array[AudioStreamWAV] = []

@export_group("jetpack")
@export var audio_jetpack_fire_initial :AudioStreamWAV
@export var audio_jetpack_fire_loop :AudioStreamWAV
@export var audio_jetpack_out_of_fuel :AudioStreamWAV

@export_group("laser")
@export var audio_laser_fire_initial :AudioStreamWAV
@export var audio_laser_fire_loop :AudioStreamWAV
@export var audio_laser_overheat :AudioStreamWAV
@export var audio_laser_ready :AudioStreamWAV

@export_group("player")
@export var audio_player_death :AudioStreamWAV

@export_group("boss")
@export var audio_boss_death :AudioStreamWAV
@export var audio_boss_dash :AudioStreamWAV
@export var audio_boss_laser :AudioStreamWAV
@export var audio_boss_damage :Array[AudioStreamWAV] = []


func _ready () -> void:
    _MenuMusic.play()
    _AmbientSound.play()


func play_stream_oneshot (stream :AudioStream) -> AudioStreamPlayer:
    var audio_player = AudioStreamPlayer.new()
    _AudioSpawner.add_child(audio_player)
    audio_player.stream = stream
    audio_player.finished.connect(func(): audio_player.queue_free())
    audio_player.play()
    return audio_player


func get_play_stream_reference (stream :AudioStream) -> AudioStreamPlayer:
    var audio_player = AudioStreamPlayer.new()
    _AudioSpawner.add_child(audio_player)
    audio_player.stream = stream
    audio_player.finished.connect(func(): audio_player.queue_free())
    audio_player.play()
    return audio_player


func clean_up_audio_players () -> void:
    for child in _AudioSpawner.get_children():
        child.queue_free()


func toggle_music () -> void:
    if _LevelMusic.playing:
        _LevelMusic.stop()
        _MenuMusic.play(0.0)
    else:
        _MenuMusic.stop()
        _LevelMusic.play(0.0)
