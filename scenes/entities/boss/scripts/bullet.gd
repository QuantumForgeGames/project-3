extends Area2D

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_parent().find_child("Player") # REMOVE
@onready var sprite_2d = $Sprite2D


var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


@export var speed: float = 40


func _ready():
    if player != null:
        direction = (player.position - position).normalized()
    else: direction = Vector2.LEFT


func _physics_process(delta):
    velocity = direction * speed
    rotation = velocity.angle()

    velocity = velocity.limit_length(150)

    position += velocity


func _on_body_entered(body):
    if body.is_in_group("player"):
        body.get_child(0).find_child("Health").take_damage(25)
    queue_free()