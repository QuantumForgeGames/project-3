extends Node


# const GRAVITY = 500.0
const GRAVITY        :float = 9.8 *10
const JETPACK_FORCE  :float = -300.0
const MOVE_SPEED     :float = 200.0
const MAX_FALL_SPEED :float = 500.0

var _is_jetpacking = false


func _process (_delta_ :float) -> void:

    var direction :float = 0.
    if Input.is_action_pressed("ui_left"): direction -= 1
    if Input.is_action_pressed("ui_right"): direction += 1
    if Input.is_action_pressed("ui_up"): _is_jetpacking = true
    else: _is_jetpacking = false

    owner.velocity.x = direction * MOVE_SPEED

    if not _is_jetpacking: owner.velocity.y += GRAVITY
    else:                  owner.velocity.y = JETPACK_FORCE

    if owner.velocity.y > MAX_FALL_SPEED:
        owner.velocity.y = MAX_FALL_SPEED

    owner.move_and_slide()
    if owner.is_on_floor(): _is_jetpacking = false

