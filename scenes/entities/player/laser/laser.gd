extends Node2D


var _length :float = 0.0
var _collision_area = null
var _use_collision :bool = false

@onready var _CollisionShape_ :CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var line_2d = $Line2D
@onready var orb_sprite = $OrbSprite


func handle_update (value_ :float) -> void:

    var collisionLength :float = 0.0
    if _use_collision and _collision_area != null:
        collisionLength = (_collision_area.global_position - global_position).length()
    else:
        collisionLength = _length

    collisionLength = min(collisionLength, 1880.0 - global_position.x)

    line_2d.points[0] = Vector2(0.0, 0.0)
    line_2d.points[1] = Vector2(collisionLength, 0.0)

    if value_ > 0.0: 
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


    _CollisionShape_.shape.size.x = int(collisionLength)
    _CollisionShape_.position.x = collisionLength /2.0
    # queue_redraw()


#func _draw () -> void:
    #draw_line(Vector2(0.0, 0.0), Vector2(_length, 0.0), Color(1.0, 1.0, 1.0, 1.0), 30.0)
    ##sprite_2d.position(Vector2(0.0, 0.0))
    #animation_player.play("shoot")


func _on_area_2d_area_entered(area):
    _collision_area = area
    _use_collision = true

func _on_area_2d_area_exited(_area):
    _collision_area = null
    _use_collision = false
