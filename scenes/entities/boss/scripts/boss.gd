extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_END_POSITION: int = 250
const DASH_START_POSITION: int = 1550

@onready var progress_bar = $UI/ProgressBar

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health: int = 100
var audio_cue_timout: float = 1.0

@onready var _health :Node = $'Health'
var _process_damages: Array = []


func _ready () -> void:
	_health.update.connect($'UI/ProgressBar'.handle_update)
	progress_bar.value = health


func _process (delta_) -> void:
	for node in _process_damages:
		node.take_damage(delta_ * 4.0)
		if audio_cue_timout > 0.75:
			AudioManager.play_stream_oneshot(AudioManager.audio_boss_damage.pick_random())
			audio_cue_timout = 0.0
		audio_cue_timout += delta_


func _physics_process (_delta) -> void:
	pass
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()

func _notification(_what :int) -> void:
	if _what == NOTIFICATION_PREDELETE:
		AudioManager.play_stream_oneshot(AudioManager.audio_boss_death)


func _on_damage_detection_area_entered (_marea) -> void:
	if not _process_damages.has(_health):
		_process_damages.append(_health)
		audio_cue_timout = 1.0

func _on_damage_detection_area_exited (_area) -> void:
	if _process_damages.has(_health):
		_process_damages.erase(_health)
