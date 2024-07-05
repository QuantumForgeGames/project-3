extends Node2D

const START_POS = Vector2(50, -100)
const CAM_START_POS = Vector2()

var screen_size: Vector2

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	screen_size = get_window().size
	

func new_game():
	#player.position = START_POS
	player.velocity = Vector2(0, 0)
	#$Camera2D.position = CAM_START_POS
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player.position.x += 5.0
	$Camera2D.position.x += 5.0
	
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
		print("TRUE")
