extends State

@onready var collision_shape = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = $"../../UI/ProgressBar"
@onready var cooldown_timer = $"../../CooldownTimer"


var can_attack: bool = false
var can_shoot: bool = false
var can_dash: bool = false
var rng = RandomNumberGenerator.new()
var state: int = 1

#var player_entered: bool = false:
	#set(value):
		#player_entered = value
		#collision_shape.set_deferred("disabled", value)
		#progress_bar.set_deferred("visible", value)

func enter():
	super.enter()
	animation_player.play("idle")
	can_attack = false
	cooldown_timer.start()
	#state = randi_range(1, 2)

func transition():
	if can_attack:
		match state:
			1:
				state = 2
				get_parent().change_state("Shoot")
			2:
				state = 1
				get_parent().change_state("Dash")

#func _on_player_detection_body_entered(body):
	#player_entered = true

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_dash_timer_timeout():
	can_dash = true

func _on_cooldown_timer_timeout():
	can_attack = true
