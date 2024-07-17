extends State

var can_transition: bool = false

func enter():
	super.enter()
	await dash()
	#can_transition = true
	
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Move")
		
func dash():
	AudioManager.play_stream_oneshot(AudioManager.audio_boss_dash)
	animation_player.play("attack")
	await animation_player.animation_finished
	#owner.position.x = move_toward(owner.position.x, -owner.DASH_END_POSITION, 15)
	#owner.position.x -= owner.DASH_AMOUNT
	
func _physics_process(delta):
	super._physics_process(delta)
	owner.position.x = move_toward(owner.position.x, owner.DASH_END_POSITION, 15)
	if owner.position.x == owner.DASH_END_POSITION:
		can_transition = true
