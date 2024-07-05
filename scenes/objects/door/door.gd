extends Node2D

var is_opened = false
@onready var sprite_2d = $Sprite2D2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_door_open():
	is_opened = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_opened == true:
		sprite_2d.visible = true
