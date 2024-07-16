extends Node


# const GRAVITY = 500.0
@export var  GRAVITY        :float = 9.8 *10
const JETPACK_FORCE  :float = -300.0
const MOVE_SPEED     :float = 200.0
const MAX_FALL_SPEED :float = 500.0

var _is_jetpacking = false
var fuel = 100
var _jetpack_fire_loop :AudioStreamPlayer = null

@onready var label = $"../../Label"
@onready var propulsion: Node2D = $"../../view/Propulsion"


func _process (_delta_ :float) -> void:
    label.text = str(fuel)

    var direction :float = 0.
    if Input.is_action_pressed("move_left") and fuel > 0: 
        direction -= 1
        if fuel > 0:
            fuel -= 0.5
        
    if Input.is_action_pressed("move_right") and fuel > 0: 
        direction += 1
        if fuel > 0:
            fuel -= 0.5
        
    _is_jetpacking = false
    
    if Input.is_action_pressed("move_up") and fuel > 0:
        _is_jetpacking = true

    if Input.is_action_just_pressed("move_up"):
        if fuel <= 0: AudioManager.play_stream_oneshot(AudioManager.audio_jetpack_out_of_fuel)
        else:
            AudioManager.play_stream_oneshot(AudioManager.audio_jetpack_fire_initial)
            if _jetpack_fire_loop == null: _jetpack_fire_loop = AudioManager.get_play_stream_reference(AudioManager.audio_jetpack_fire_loop)
            else: _jetpack_fire_loop.quque_free()
    elif Input.is_action_just_released("move_up"):
        if _jetpack_fire_loop != null: _jetpack_fire_loop.queue_free()
    elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") and fuel <= 0:
        AudioManager.play_stream_oneshot(AudioManager.audio_jetpack_out_of_fuel)


    owner.velocity.x = direction * MOVE_SPEED


    if not _is_jetpacking: 
        #propulsion.get_child(0).amount = 1000
        #move_toward(propulsion.get_child(0).amount, 1, 1)
        for x in range(6):
            propulsion.get_child(x).emitting = false
        owner.velocity.y += GRAVITY
    else:
        for x in range(6):
            propulsion.get_child(x).emitting = true
        owner.velocity.y = JETPACK_FORCE
        if fuel > 0:
            fuel -= 0.1
        elif fuel < 0:
            fuel = 0
            
    if owner.is_on_floor():
        if fuel < 100:
            fuel += 2
        elif fuel > 100:
            fuel = 100

    if owner.velocity.y > MAX_FALL_SPEED:
        owner.velocity.y = MAX_FALL_SPEED

    owner.move_and_slide()
    if owner.is_on_floor(): _is_jetpacking = false


func _notification(_what :int) -> void:
    if _what == NOTIFICATION_PREDELETE:
        if _jetpack_fire_loop != null: _jetpack_fire_loop.queue_free()
