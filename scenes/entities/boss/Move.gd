extends State

var can_transition: bool = false
var target_location: float

func enter():
	super.enter()
	can_transition = false
	animation_player.play("idle")
	target_location = owner.position.x + 1000
	

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Idle")

func _physics_process(delta):
	super._physics_process(delta)
	owner.position.x = move_toward(owner.position.x, owner.DASH_START_POSITION, 5)
	if owner.position.x == owner.DASH_START_POSITION:
		can_transition = true
	
