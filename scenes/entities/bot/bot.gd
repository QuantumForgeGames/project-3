extends CharacterBody2D

var speed = 300
var acceleration = 7
var rng = RandomNumberGenerator.new()

@export var new_position = Vector2()

@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	var random_x = rng.randf_range(0, 1000)
	var random_y = rng.randf_range(0, 1000)
	new_position = Vector2(random_x, random_y)

func _physics_process(delta):
	var direction = Vector3()
	
	navigation_agent_2d.target_position = new_position
	
	direction = navigation_agent_2d.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	
	#print(diresction)
	#print(new_position)
	
	move_and_slide()


func _on_timer_timeout():
	var random_x = rng.randf_range(0, 1000)
	var random_y = rng.randf_range(0, 1000)
	new_position = Vector2(random_x, random_y)

