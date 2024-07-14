extends Node2D


var _length :float = 0.0
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var line_2d = $Line2D
@onready var orb_sprite = $OrbSprite


func handle_update (value_ :float) -> void:
	line_2d.points[0] = Vector2(0.0, 0.0)
	line_2d.points[1] = Vector2(_length, 0.0)
	
	if value_ > 0.0: 
		print(_length)
		if _length < 34.0:
			animation_player.play("fade_in")
			await animation_player.animation_finished
			orb_sprite.animation = "shoot"
		_length += value_
	else: 
		if _length > 34.0:
			orb_sprite.animation = "default"
			animation_player.play_backwards("fade_in")
		_length = 0.0
		
	queue_redraw()
	

#func _draw () -> void:
	#draw_line(Vector2(0.0, 0.0), Vector2(_length, 0.0), Color(1.0, 1.0, 1.0, 1.0), 30.0)
	##sprite_2d.position(Vector2(0.0, 0.0))
	#animation_player.play("shoot")
